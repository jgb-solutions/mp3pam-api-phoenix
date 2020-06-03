defmodule MP3PamWeb.Resolvers.Playlist do
  alias MP3Pam.Repo
  alias MP3Pam.Models.Playlist

  def all(_args, _resolution) do
    {:ok, Repo.all(Playlist)}
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
