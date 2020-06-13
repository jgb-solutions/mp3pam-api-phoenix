defmodule MP3PamWeb.Resolvers.Track do
  alias MP3Pam.Repo
  import Ecto.Query
  alias MP3Pam.RepoHelper
  alias MP3Pam.Models.Track
  alias MP3Pam.Models.Genre
  alias MP3Pam.Utils
  alias Size

  def paginate(args, _resolution) do
    page = args[:page] || 1
    page_size = args[:take] || 20

    q =
      from RepoHelper.latest(Track),
        preload: [:artist, :genre]

    paginated_tracks =
      q
      |> RepoHelper.paginate(page: page, page_size: page_size)

    paginated_tracks_with_poster_url =
      Map.put(
        paginated_tracks,
        :data,
        Enum.map(paginated_tracks.data, &Track.with_poster_url(&1))
      )

    {:ok, paginated_tracks_with_poster_url}
  end

  def related_tracks(%{input: %{hash: hash, take: take}}, _resolution) do
    q =
      from t in Track,
        preload: [:artist, :album],
        where: t.hash != ^hash,
        limit: ^take,
        order_by: fragment("RAND()")

    tracks_with_poster_url =
      Repo.all(q)
      |> Enum.map(&Track.with_poster_url(&1))

    {:ok, tracks_with_poster_url}
  end

  def find_by_hash(args, _resolution) do
    q =
      from t in Track,
        where: t.hash == ^args.hash,
        preload: [:album, :artist, :genre]

    case Repo.one(q) do
      %Track{} = track ->
        {
          :ok,
          track
          |> Track.with_poster_url()
          |> Track.with_audio_url()
          |> Map.update!(:audio_file_size, &Size.humanize!(String.to_integer(&1)))
        }

      nil ->
        {:error, message: "Track Not Found", code: 404}
    end
  end

  def tracks_by_genre(args, _resolution) do
    %{
      take: take,
      slug: slug,
      order_by: order_by_list
    } = args

    page = args[:page] || 1

    case Repo.get_by(Genre, slug: slug) do
      %Genre{} = genre ->
        q =
          from t in Track,
            where: t.genre_id == ^genre.id,
            preload: [:artist],
            order_by: ^Utils.make_order_by_list(order_by_list)

        paginated_tracks = RepoHelper.paginate(q, page: page, page_size: take)

        paginated_tracks_with_poster_url =
          Map.put(
            paginated_tracks,
            :data,
            Enum.map(paginated_tracks.data, &Track.with_poster_url(&1))
          )

        {:ok, paginated_tracks_with_poster_url}

      nil ->
        {:error, message: "Track Not Found", code: 404}
    end
  end
end
