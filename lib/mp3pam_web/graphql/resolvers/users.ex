defmodule MP3PamWeb.Resolvers.User do
  alias MP3Pam.Models.User
  alias MP3Pam.Repo

  def all(_args, _resolution) do
    {:ok, Repo.all(User)}
  end

  def find(args, _resolution) do
    {:ok, Repo.get(User, args.id)}
  end

  def create_user(args, _resolution) do
    user = %User{
      name: args.name,
      email: args.email,
      password: args.password,
      telephone: args.telephone
    }

    {:ok, Repo.insert!(user)}
  end

  def me(_, %{context: %{current_user: user}}) do
    {:ok, user}
  end
end
