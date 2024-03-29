defmodule MP3PamWeb.Resolvers.Auth do
  alias MP3Pam.Repo
  alias MP3Pam.Models.User
  import Bcrypt, only: [verify_pass: 2]

  def register(args, _resolution) do
    {:ok, User.register(args)}
  end

  def login(%{input: %{email: email, password: password}}, _info) do
    user = Repo.get_by(User, email: String.downcase(email))

    if user && verify_pass(password, user.password) do
      token =
        Phoenix.Token.sign(
          MP3PamWeb.Endpoint,
          Application.fetch_env!(:mp3pam, :auth_salt),
          user.id
        )

      response = %{
        data: user |> User.with_avatar_url(),
        token: token
      }

      {:ok, response}
    else
      {:error, message: "User not found", code: 404}
    end
  end

  def logout(_args, %{context: %{current_user: current_user}}) do
    {:ok, current_user}
  end

  def logout(_args, _info) do
    {:error, message: "You Need to login", code: 403}
  end
end
