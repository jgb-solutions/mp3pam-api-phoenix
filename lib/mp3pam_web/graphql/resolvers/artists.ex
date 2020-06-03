defmodule MP3PamWeb.Resolvers.Artist do
  alias MP3Pam.Repo
  alias MP3Pam.Models.Artist

  def all(_args, _resolution) do
    {:ok, Repo.all(Artist)}
  end

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