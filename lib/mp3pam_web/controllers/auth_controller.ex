defmodule MP3PamWeb.AuthController do
  use MP3PamWeb, :controller
  plug Ueberauth

  require Logger
  require Poison

  # alias Ueberauth.Strategy.Helpers
  alias Ueberauth.Auth

  import Ecto.Query
  import Ecto.Changeset
  alias MP3Pam.Models.User
  alias MP3Pam.Repo

  def find_or_create(%Auth{} = auth) do
    {:ok, basic_info(auth)}
  end

  # github does it this way
  defp avatar_from_auth(%{info: %{urls: %{avatar_url: image}}}), do: image

  # facebook does it this way
  defp avatar_from_auth(%{info: %{image: image}}), do: image

  # default case if nothing matches
  defp avatar_from_auth(auth) do
    Logger.warn("#{auth.provider} needs to find an avatar URL!")
    Logger.debug(Poison.encode!(auth))
    nil
  end

  defp basic_info(%{info: info} = auth) do
    %{
      id: auth.uid,
      name: name_from_auth(auth),
      avatar: avatar_from_auth(auth),
      email: info.email,
      profile_url: info.urls.facebook
    }
  end

  defp name_from_auth(auth) do
    if auth.info.name do
      auth.info.name
    else
      name =
        [auth.info.first_name, auth.info.last_name]
        |> Enum.filter(&(&1 != nil and &1 != ""))

      if Enum.empty?(name) do
        auth.info.nickname
      else
        Enum.join(name, " ")
      end
    end
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "You have been logged out!")
    |> clear_session()
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    json_response = Jason.encode!(%{error: true})

    redirect(conn, external: "http://localhost:3000/auth/facebook?response=" <> json_response)
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    fb_user = basic_info(auth)

    user_query =
      from u in User,
        where: u.facebook_id == ^fb_user.id,
        or_where: u.email == ^fb_user.email,
        limit: 1

    new_or_updated_user =
      case Repo.one(user_query) do
        nil ->
          userStruct = %User{
            facebook_id: fb_user.id,
            name: fb_user.name,
            email: fb_user.email,
            fb_avatar: fb_user.avatar,
            facebook_link: fb_user.profile_url
          }

          Repo.insert!(userStruct)

        user ->
          cond do
            !(is_nil(user.avatar) && is_nil(user.fb_avatar)) ->
              {:ok, user} = Repo.update(change(user, fb_avatar: fb_user.avatar))
              user

            true ->
              user
          end
      end

    token =
      Phoenix.Token.sign(
        MP3PamWeb.Endpoint,
        Application.fetch_env!(:mp3pam, :auth_salt),
        new_or_updated_user.id
      )

    user_with_avatar_url = new_or_updated_user |> User.with_avatar_url()

    response = %{
      data: %{
        id: user_with_avatar_url.id,
        name: user_with_avatar_url.name,
        email: user_with_avatar_url.email,
        avatarUrl: user_with_avatar_url.avatar_url,
        telephone: user_with_avatar_url.telephone,
        insertedAt: user_with_avatar_url.inserted_at,
        firstLogin: user_with_avatar_url.first_login
      },
      token: token
    }

    if new_or_updated_user.first_login do
      updated_user = change(new_or_updated_user, first_login: false)

      Repo.update(updated_user)
    end

    json_response = Jason.encode!(response)

    redirect(conn, external: "http://localhost:3000/auth/facebook?response=" <> json_response)
  end
end
