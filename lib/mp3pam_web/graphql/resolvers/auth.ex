defmodule MP3PamWeb.Resolvers.Auth do
  alias MP3Pam.Repo
  alias MP3Pam.Models.User
  import Bcrypt, only: [check_pass: 2]

  def login(email, password) do
    %User{} = user = Repo.get_by(User, email: String.downcase(email))

    cond do
      user && check_pass(user, password) ->
        {:ok, user}

      true ->
        {:error, :"User not found"}
    end
  end

  def logout(_args, %{context: %{current_user: current_user}}) do
    User.remove_token(current_user, nil)
    {:ok, current_user}
  end

  def logout(_args, _info) do
    {:error, "You Need to login", code: 403}
  end
end
