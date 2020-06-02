defmodule MP3PamWeb.Resolvers.User do
  alias MP3Pam.Models.User
  alias MP3Pam.Repo

  def all(_parent, _args, _resolution) do
    {:ok, Repo.all(User)}
  end

  def find(_parent, args, _resolution) do
    {:ok, Repo.get(User, args.id)}
  end
end
