defmodule MP3PamWeb.Resolvers.Artist do
  alias MP3Pam.Repo
  import Ecto.Query
  alias MP3Pam.RepoHelper
  alias MP3Pam.Models.Artist

  def paginate(args, _resolution) do
    page =  args[:page] || 1
    page_size = args[:take] || 20

    q = from RepoHelper.latest(Artist),
      preload: [:albums]

    paginated_artists =
      q
      |> RepoHelper.paginate(page: page, page_size: page_size)

    paginated_artists_with_poster_url = %{
      paginated_artists |
      data: Enum.map(paginated_artists.data, &(Artist.with_poster_url(&1)))
    }

    {:ok, paginated_artists_with_poster_url}
  end

  @spec find(any, atom | %{id: any}, any) :: {:ok, any}
  def find(_parent, args, _resolution) do
    {:ok, Repo.get(Artist, args.id)}
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

  def random_artists(args, _resolution) do
    # todo
    {:ok, "url"}
  end
end
