defmodule MP3PamWeb.Resolvers.Artist do
  alias MP3Pam.Repo
  import Ecto.Query
  alias MP3Pam.RepoHelper
  alias MP3Pam.Models.Artist
  alias MP3Pam.Models.Track
  alias MP3Pam.Models.Album

  def paginate(args, _resolution) do
    page = args[:page] || 1
    page_size = args[:take] || 20

    q =
      from RepoHelper.latest(Artist),
        preload: [:albums]

    paginated_artists =
      q
      |> RepoHelper.paginate(page: page, page_size: page_size)

    paginated_artists_with_poster_url = %{
      paginated_artists
      | data: Enum.map(paginated_artists.data, &Artist.with_poster_url(&1))
    }

    {:ok, paginated_artists_with_poster_url}
  end

  def find_by_hash(args, _resolution) do
    tracks_query =
      from t in Track,
        order_by: [desc: t.inserted_at]

    albums_query =
      from t in Album,
        order_by: [desc: t.inserted_at]

    q =
      from a in Artist,
        where: a.hash == ^args.hash,
        preload: [
          tracks: ^tracks_query,
          albums: ^albums_query
        ],
        limit: 1

    case Repo.one(q) do
      %Artist{} = artist ->
        artist_with_cover_url = artist |> Artist.with_poster_url()

        data = %{
          artist_with_cover_url
          | tracks:
              Enum.map(artist_with_cover_url.tracks, fn track ->
                track
                |> Track.with_poster_url()
                |> Track.with_audio_url()
              end),
            albums:
              Enum.map(artist_with_cover_url.albums, fn album ->
                album
                |> Album.with_cover_url()
              end)
        }

        {:ok, data}

      nil ->
        {:error, message: "Artist Not Found", code: 404}
    end
  end
end
