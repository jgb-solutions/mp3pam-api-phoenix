defmodule MP3PamWeb.Resolvers.Album do
  alias MP3Pam.Repo
  alias MP3Pam.RepoHelper
  import Ecto.Query
  alias MP3Pam.Models.Album

  def paginate(args, _resolution) do
    page =  args["page"] || 1
    page_size = args["take"] || 5

    q = from a in Album,
      preload: [artist: [tracks: [:genre]]],
      limit: 20

    paginated_albums =
      q
      |> RepoHelper.paginate(page: page, page_size: page_size)

      paginated_albums_with_cover_url = %{
        paginated_albums |
        data: Enum.map(paginated_albums.data, &(Album.with_cover_url(&1)))
      }
      IO.inspect(paginated_albums_with_cover_url)
    {:ok, paginated_albums_with_cover_url}
  end

  # def all(_args, _resolution) do
  #   q = from a in Album,
  #     preload: [artist: [tracks: [:genre]]],
  #     limit: 20

  #   {:ok, Repo.all(q)}
  # end

  def find(_parent, args, _resolution) do
    {:ok, Repo.get(Album, args.id)}
  end

  # create track context user // %{context: %{current_user: user}}

  def upload_url(args, _resolution) do
    # todo
    {:ok, "url"}
  end

  def find_by_hash(args, _resolution) do
    # todo
    {:ok, "url"}
  end

  def random_albums(args, _resolution) do
    # todo
    {:ok, "url"}
  end


end
