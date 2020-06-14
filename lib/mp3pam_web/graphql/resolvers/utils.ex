defmodule MP3PamWeb.Resolvers.Utils do
  alias MP3Pam.Repo
  import Ecto.Query
  alias MP3Pam.Models.User
  alias MP3Pam.Models.Album
  alias MP3Pam.Models.Genre
  alias MP3Pam.Models.Track
  alias MP3Pam.Models.Artist
  alias MP3Pam.Models.Playlist

  def all(_parent, _args, _resolution) do
    {:ok, Repo.all(Track)}
  end

  def find(_parent, args, _resolution) do
    {:ok, Repo.get(Track, args.id)}
  end

  # create track context user // %{context: %{current_user: user}}

  def upload_url(args, _resolution) do
    %{
      input: %{
        name: name,
        bucket: bucket,
        public: public,
        attachment: attachment
      }
    } = args

    filePath = make_upload_file_path(name)

    # params = []

    # params = [{"x-amz-acl", "public-read"} | params]

    # params = [{"contentDisposition", "attachment; filename=" <> name} | params]

    # IO.inspect(params)
    # NOTE: Also set option `virtual_host: true` if using an EU region

    {:ok, url} =
      ExAws.S3.presigned_url(
        ExAws.Config.new(:s3),
        :put,
        bucket,
        filePath,
        # {:content_disposition, "attachment; filename=" <> name},
        # {:content_type, binary()},
        # {:expires, binary()},
        # {:acl, :public_read}
        # expires_in: integer(),
        # virtual_host: boolean(),
        query_params: [
          # {"x-amz-acl", "public-read"},
          # {"Content-Disposition", "attachment; filename=" <> name}
        ]
      )

    {:ok,
     %{
       signed_url: url,
       filename: filePath
     }}
  end

  defp make_upload_folder() do
    # TODO
    user = %{id: 1}
    # user = auth()->guard("api")->user();
    %{
      year: year,
      month: month,
      day: day
    } = Date.utc_today()

    "user_" <> to_string(user.id) <> "/#{year}/#{month}/#{day}"
  end

  defp make_upload_file_name(name) do
    to_string(:os.system_time(:millisecond)) <> Path.extname(name)
  end

  defp make_upload_file_path(name) do
    make_upload_folder() <> "/" <> make_upload_file_name(name)
  end

  def facebook_login_url(args, _resolution) do
    # todo
    {:ok, "Yeah"}
  end

  def download(args, _resolution) do
    # todo
    {:ok, "Yeah"}
  end

  def search(args, _resolution) do
    result =
      Enum.map([Album, Track, Artist], fn struct ->
        do_search(struct, args.term)
      end)

    {:ok, result}
  end

  def do_search(%Album{} = struct, term) do
    query =
      from t in struct,
        where: like(t.title, ^term),
        select: [:id, :title]

    Repo.all(query)
  end

  def do_search(%Track{} = struct, term) do
    query =
      from t in struct,
        where: like(t.title, ^term),
        select: [:id, :title]

    Repo.all(query)
  end

  def do_search(%Artist{} = struct, term) do
    query =
      from t in struct,
        where: like(t.title, ^term),
        select: [:id, :title]

    Repo.all(query)
  end
end
