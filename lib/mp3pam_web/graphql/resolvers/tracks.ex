defmodule MP3PamWeb.Resolvers.Track do
  alias MP3Pam.Repo
  import Ecto.Query
  alias MP3Pam.RepoHelper
  alias MP3Pam.Models.Track

  def paginate(args, _resolution) do
    page =  args[:page] || 1
    page_size = args[:take] || 20

    q = from RepoHelper.latest(Track),
      preload: [:artist, :genre]

    paginated_tracks =
      q
      |> RepoHelper.paginate(page: page, page_size: page_size)

    paginated_tracks_with_poster_url = Map.put(
      paginated_tracks,
      :data,
      Enum.map(paginated_tracks.data, &(Track.with_poster_url(&1)))
    )

    {:ok, paginated_tracks_with_poster_url}
  end

  def find(_parent, args, _resolution) do
    {:ok, Repo.get(Track, args.id)}
  end

  # create track context user // %{context: %{current_user: user}}

  def upload_url(args, _resolution) do
    # todo
    {:ok, "url"}
  end

  def tracks_by_genre(args, _resolution) do
    {:ok, "track"}
  end

  def related_tracks(%{input: %{hash: hash, take: take}}, _resolution) do
    q = from t in Track,
    where: t.hash != ^hash,
    order_by: fragment("RAND()"),
    limit: ^take,
    preload: [:artist, :album]

    tracks_with_poster_url =
      Repo.all(q)
      |> Enum.map(&(Track.with_poster_url(&1)))

    {:ok, tracks_with_poster_url}
  end

  def find_by_hash(args, _resolution) do
    q = from t in Track,
    where: t.hash == ^args.hash,
    preload: [:album, :artist, :genre]

    case Repo.one(q) do
      %Track{} = track -> {
        :ok, track
          |> Track.with_poster_url
          |> Track.with_audio_url
        }
      nil -> {:error, message: "Track Not Found", code: 404}
    end
  end
end
