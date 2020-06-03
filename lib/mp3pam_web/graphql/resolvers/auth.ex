defmodule MP3PamWeb.Resolvers.Auth do
  alias MP3Pam.Repo
  alias MP3Pam.Models.User

  def login(args, _resolutions) do
    {:ok, true}
  end
end
