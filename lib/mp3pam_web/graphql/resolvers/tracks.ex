defmodule MP3PamWeb.Resolvers.Track do
  alias MP3Pam.Models.Track
  alias MP3Pam.Repo

  def all(_parent, _args, _resolution) do
    {:ok, Repo.all(Track)}
  end

  def find(_parent, args, _resolution) do
    {:ok, Repo.get(Track, args.id)}
  end
end
