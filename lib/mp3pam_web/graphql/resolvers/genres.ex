defmodule MP3PamWeb.Resolvers.Genre do
  alias MP3Pam.Repo
  import Ecto.Query
  alias MP3Pam.Models.Genre

  def all(_args, _resolution) do
    q = from Genre,
    order_by: [asc: :name]

    {:ok, Repo.all(q)}
  end

  def find(_parent, args, _resolution) do
    {:ok, Repo.get(Genre, args.id)}
  end

  # create track context user // %{context: %{current_user: user}}

  def upload_url(args, _resolution) do
    # todo
    {:ok, "url"}
  end

  def find_by_slug(args, _resolution) do
    # todo
    {:ok, "slug"}
  end
end
