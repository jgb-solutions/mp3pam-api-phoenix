defmodule MP3PamWeb.Resolvers.User do
  alias MP3Pam.Repo
  import Ecto.Query
  alias MP3Pam.RepoHelper
  alias MP3Pam.Models.User
  alias MP3PamWeb.Resolvers.Auth

  def paginate(args, _resolution) do
    page = args[:page] || 1
    page_size = args[:take] || 20

    q =
      from RepoHelper.latest(User),
        preload: [:artists, :albums, :playlists, :tracks]

    paginated_users =
      q
      |> RepoHelper.paginate(page: page, page_size: page_size)

    paginated_users_with_avatar_url =
      Map.put(
        paginated_users,
        :data,
        Enum.map(paginated_users.data, &User.with_avatar_url(&1))
      )

    {:ok, paginated_users_with_avatar_url}
  end

  def find(args, _resolution) do
    {:ok, Repo.get(User, args.id)}
  end

  def create_user(args, _resolution) do
    {:ok, User.create_user(args)}
  end

  def me(_, %{context: %{current_user: user}}) do
    {:ok, user}
  end

  def login(%{email: email, password: password}, _resolution) do
    with {:ok, %User{} = user} <- Auth.login(email, password),
         {:ok, jwt, _} <- MP3Pam.Guardian.encode_and_sign(user),
         {:ok, _} <- User.store_token(user, jwt) do
      {:ok, %{token: jwt}}
    end
  end
end
