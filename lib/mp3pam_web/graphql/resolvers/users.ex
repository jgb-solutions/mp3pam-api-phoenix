defmodule MP3PamWeb.Resolvers.User do
  alias MP3Pam.Repo
  import Ecto.Query
  alias MP3Pam.RepoHelper
  alias MP3Pam.Models.User
  alias MP3Pam.Models.Artist
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

  def me(_, %{context: %{current_user: user}}) do
    artists_query =
      from a in Artist,
        where: a.user_id == ^user.id,
        order_by: [asc: :stage_name]

    artists_by_stage_name = Repo.all(artists_query)

    {:ok, %{user | artists: artists_by_stage_name}}
  end

  def me(_, _) do
    {:error, message: "You Need to login", code: 403}
  end

  def login(%{email: email, password: password}, _resolution) do
    Auth.login(email, password)
  end
end
