defmodule MP3Pam.Models.Album do
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

  @default_poster_url "https://img-storage-prod.mp3pam.com/placeholders/album-placeholder.jpg"

  schema "albums" do
    field :cover, :string
    field :detail, :string
    field :hash, :integer
    field :img_bucket, :string
    field :release_year, :integer
    field :title, :string
    field :cover_url, :string, virtual: true
    timestamps()

    belongs_to :artist, Artist
    has_many :track, Track
    belongs_to :user, User
  end

  @doc false
  def changeset(album, attrs) do
    album
    |> cast(attrs, [:title, :hash, :cover, :img_bucket, :detail, :user_id, :artist_id, :release_year])
    |> validate_required([:title, :hash, :cover, :img_bucket, :detail, :user_id, :artist_id, :release_year])
  end

  def random do
    query = from u in Album,
    order_by: fragment("RAND()"),
    limit: 1

    Repo.one(query)
  end

  def make_cover_url(%Album{} = album) do
    if album.cover do
      "https://" <> album.img_bucket <> "/" <> album.cover
    else
      @default_poster_url
    end
  end

  def with_cover_url(%__MODULE__{} = album) do
    %{album | cover_url: make_cover_url(album)}
  end
end
