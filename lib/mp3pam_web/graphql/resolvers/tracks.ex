defmodule MP3PamWeb.Resolvers.Track do
  alias MP3Pam.Repo
  alias MP3Pam.Models.Track

  def all(_args, _resolution) do
    {:ok, Repo.all(Track)}
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

  def related_tracks(args, _resolution) do
    {:ok, "track"}
  end

  def find_by_hash(args, _resolution) do
    {:ok, "track"}
  end
end
