defmodule MP3PamWeb.Resolvers.Album do
  alias MP3Pam.Repo
  alias MP3Pam.RepoHelper
  import Ecto.Query
  alias MP3Pam.Models.Album
  alias MP3Pam.Models.Track

  def paginate(args, _resolution) do
    page = args[:page] || 1
    page_size = args[:take] || 20

    q =
      from RepoHelper.latest(Album),
        preload: [artist: [tracks: [:genre]]]

    paginated_albums =
      q
      |> RepoHelper.paginate(page: page, page_size: page_size)

    paginated_albums_with_cover_url =
      Map.put(
        paginated_albums,
        :data,
        Enum.map(paginated_albums.data, &Album.with_cover_url(&1))
      )

    {:ok, paginated_albums_with_cover_url}
  end

  def find_by_hash(args, _resolution) do
    tracks_query =
      from t in Track,
        order_by: [asc: t.number]

    q =
      from a in Album,
        where: a.hash == ^args.hash,
        preload: [
          :artist,
          tracks: ^tracks_query
        ],
        limit: 1

    case Repo.one(q) do
      %Album{} = album ->
        album_with_cover_url = album |> Album.with_cover_url()

        data = %{
          album_with_cover_url
          | tracks:
              Enum.map(album_with_cover_url.tracks, fn track ->
                track
                |> Track.with_poster_url()
                |> Track.with_audio_url()
              end)
        }

        {:ok, data}

      nil ->
        {:error, message: "Album Not Found", code: 404}
    end
  end

  def random_albums(%{input: %{hash: hash, take: take}}, _resolution) do
    q =
      from a in Album,
        preload: [:artist],
        where: a.hash != ^hash,
        limit: ^take,
        order_by: fragment("RAND()")

    data =
      Repo.all(q)
      |> Enum.map(&Album.with_cover_url(&1))

    {:ok, data}
  end
end
