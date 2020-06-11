defmodule MP3PamWeb.Resolvers.Genre do
  alias MP3Pam.Repo
  import Ecto.Query
  import MP3Pam.RepoHelper
  alias MP3Pam.Models.Genre
  alias MP3Pam.Models.Track

  def all(_args, _resolution) do
    q = from g in Genre,
    distinct: true,
    select: [:id, :name, :slug],
    join: t in Track, on: g.id == t.genre_id,
    # group_by: g.id,
    where: fragment("exists (select id from `tracks`)"),
    order_by: [asc: :name]

    {:ok, Repo.all(q)}
  end

  def find_by_slug(%{slug: slug}, _resolution) do
    case Repo.get_by(Genre, slug: slug) do
      %Genre{} = genre -> {:ok, genre}
      nil -> {:error, message: "Track Not Found", code: 404}
    end
  end
end
