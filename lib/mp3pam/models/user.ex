defmodule MP3Pam.Models.User do
  use Ecto.Schema
  alias MP3Pam.Repo
  import Ecto.Query
  import Ecto.Changeset
  alias MP3Pam.Models.User
  alias MP3Pam.Models.Album
  alias MP3Pam.Models.Genre
  alias MP3Pam.Models.Track
  alias MP3Pam.Models.Artist
  alias MP3Pam.Models.Playlist

  schema "users" do
    field :name, :string, null: false
    field :email, :string, size: 60, unique: true
    field :password, :string, size: 60
    field :avatar, :string
    field :fb_avatar, :string
    field :facebook_id, :string, size: 16, unique: true
    field :facebook_link, :string
    field :telephone, :string, size: 20
    field :admin, :boolean, default: false
    field :active, :boolean, default: false
    field :password_reset_code, :string
    field :first_login, :boolean, default: true
    field :img_bucket, :string
    field :avatar_url, :string, virtual: true

    timestamps()

    has_many :tracks, Track
    has_many :albums, Album
    has_many :artists, Artist
    has_many :playlists, Playlist
  end

  def changeset(%__MODULE__{} = user, attrs) do
    user
    |> cast(attrs, [
      :name,
      :email,
      :password,
      :telephone,
      :facebook_link,
      :fb_avatar,
      :avatar,
      :facebook_id,
      :admin,
      :active,
      :first_login,
      :img_bucket
    ])
    |> validate_required([:name, :email, :password])
    |> unsafe_validate_unique(:email, Repo)
    # |> validate_length(:name, min: 3, max: 10)
    # |> validate_length(:password, min: 5, max: 20)
    |> hash_password()
  end

  defp hash_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :password, Bcrypt.hash_pwd_salt(password))

      _ ->
        changeset
    end
  end

  def register(attrs \\ %{}) do
    %__MODULE__{}
    |> changeset(attrs)
    |> Repo.insert!()
  end

  def get_user!(id) do
    Repo.get!(__MODULE__, id)
  end

  def random do
    q =
      from User,
        order_by: fragment("RAND()"),
        limit: 1

    Repo.one(q)
  end

  def make_avatar_url(%__MODULE__{} = user) do
    if user.avatar do
      "https://" <> user.img_bucket <> "/" <> user.avatar
    else
      user.fb_avatar
    end
  end

  def with_avatar_url(%__MODULE__{} = user) do
    %{user | avatar_url: make_avatar_url(user)}
  end
end
