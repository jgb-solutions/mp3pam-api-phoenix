defmodule MP3PamWeb.Resolvers.Auth do
  alias MP3Pam.Repo
  alias MP3Pam.Models.User
  import Bcrypt, only: [check_pass: 2]

  def register(args, _resolution) do
    {:ok, User.register(args)}
  end

  def login(%{input: %{email: email, password: password}}, _info) do
    user = Repo.get_by(User, email: String.downcase(email))

    cond do
      user && check_pass(user.password, password) ->
        {:ok, token, _claims} = MP3Pam.Guardian.encode_and_sign(user)
        User.store_token(user, token)

        response = %{
          data: user |> User.with_avatar_url(),
          token: token
        }

        {:ok, response}

      true ->
        {:error, :"User not found"}
    end
  end

  def logout(_args, %{context: %{current_user: current_user}}) do
    User.revoke_token(current_user, nil)
    {:ok, current_user}
  end

  def logout(_args, _info) do
    {:error, "You Need to login", code: 403}
  end
end
