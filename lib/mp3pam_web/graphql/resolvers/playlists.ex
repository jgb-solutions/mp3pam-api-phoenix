defmodule MP3PamWeb.Resolvers.Playlist do
  alias MP3Pam.Repo
  import Ecto.Query
  alias MP3Pam.RepoHelper
  alias MP3Pam.Models.Track
  alias MP3Pam.Models.Playlist

  def paginate(args, _resolution) do
    page = args[:page] || 1
    page_size = args[:take] || 20

    q =
      from RepoHelper.latest(Playlist),
        preload: [tracks: [:genre, :artist]]

    paginated_playlists =
      q
      |> RepoHelper.paginate(page: page, page_size: page_size)

    paginated_playlists_with_cover_url =
      Map.put(
        paginated_playlists,
        :data,
        Enum.map(
          Enum.filter(paginated_playlists.data, fn playlist ->
            length(playlist.tracks) > 0
          end),
          &Playlist.with_cover_url(&1)
        )
      )

    {:ok, paginated_playlists_with_cover_url}
  end

  def find_by_hash(args, _resolution) do
    # tracks_query = from t in Track,
    #   join: pt in "playlist_track", on: t.id == pt.track_id,
    #   preload: [:artist],
    #   order_by: [asc: pt.inserted_at]

    q =
      from p in Playlist,
        where: p.hash == ^args.hash,
        join: t in assoc(p, :tracks),
        join: pt in "playlist_track",
        on: p.id == pt.playlist_id,
        on: t.id == pt.track_id,
        preload: [:user, tracks: [:artist]],
        order_by: [asc: pt.inserted_at],
        limit: 1

    case Repo.one(q) do
      %Playlist{} = playlist ->
        IO.inspect(playlist.tracks)

        playlist_with_cover_url = playlist |> Playlist.with_cover_url()

        paginated_tracks_with_poster_url =
          Map.put(
            playlist_with_cover_url,
            :tracks,
            Enum.map(playlist_with_cover_url.tracks, fn track ->
              track
              |> Track.with_poster_url()
              |> Track.with_audio_url()
            end)
          )

        {:ok, paginated_tracks_with_poster_url}

      nil ->
        {:error, message: "Playlist Not Found", code: 404}
    end
  end
end
