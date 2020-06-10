defmodule MP3PamWeb.Resolvers.Playlist do
  alias MP3Pam.Repo
  import Ecto.Query
  alias MP3Pam.RepoHelper
  alias MP3Pam.Models.Playlist

  def paginate(args, _resolution) do
    page =  args[:page] || 1
    page_size = args[:take] || 20

    q = from RepoHelper.latest(Playlist),
      preload: [tracks: [:genre, :artist]]

    paginated_playlists =
      q
      |> RepoHelper.paginate(page: page, page_size: page_size)

    paginated_playlists_with_cover_url =  Map.put(
      paginated_playlists,
      :data,
      Enum.map(
        Enum.filter(paginated_playlists.data, fn playlist ->
          length(playlist.tracks) > 0
        end),
        &(Playlist.with_cover_url(&1)))
    )

    {:ok, paginated_playlists_with_cover_url}
  end

  def find(_parent, args, _resolution) do
    {:ok, Repo.get(Playlist, args.id)}
  end

  # create track context user // %{context: %{current_user: user}}

  def upload_url(args, _resolution) do
    # todo
    {:ok, "url"}
  end

  def random_playlists(args, _resolution) do
    {:ok, "track"}
  end

  def related_playlists(args, _resolution) do
    {:ok, "track"}
  end

  def find_by_hash(args, _resolution) do
    {:ok, "track"}
  end
end
