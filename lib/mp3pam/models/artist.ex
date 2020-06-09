defmodule MP3Pam.Models.Artist do
  use Ecto.Schema
  import Ecto.Query
  alias MP3Pam.Repo
  import Ecto.Changeset
  alias MP3Pam.Models.User
  alias MP3Pam.Models.Album
  alias MP3Pam.Models.Genre
  alias MP3Pam.Models.Track
  alias MP3Pam.Models.Artist
  alias MP3Pam.Models.Playlist

  schema "artists" do
    field :name, :string, null: false
    field :stage_name, :string, null: false
    field :hash, :integer, unique: true, null: false
    field :poster, :string
    field :img_bucket, :string, null: false
    # field :user_id, :integer
    field :bio, :string
    field :facebook, :string
    field :twitter, :string
    field :instagram, :string
    field :youtube, :string
    field :verified, :boolean, default: false
    timestamps()

    has_many :tracks, Track
    has_many :albums, Album
    belongs_to :user, User
  end

  @doc false
  def changeset(artist, attrs) do
    artist
    |> cast(attrs, [])
    |> validate_required([])
  end

  def random do
    query = from u in Artist,
    order_by: fragment("RAND()"),
    limit: 1

    Repo.one(query)
  end
end
