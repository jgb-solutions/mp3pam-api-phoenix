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

    timestamps()

    has_many :tracks, Track
    has_many :albums, Album
    has_many :artists, Artist
    has_many :playlists, Playlist
  end

  def changeset(playlist, attrs) do
    playlist
    |> cast(attrs, [:title, :hash, :user_id])
    |> validate_required([:title, :hash, :user_id])
  end

  def random do
    query = from u in User,
    order_by: fragment("RAND()"),
    limit: 1

    Repo.one(query)
  end
end
