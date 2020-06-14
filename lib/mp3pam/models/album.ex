defmodule MP3Pam.Models.Album do
  use Ecto.Schema
  import Ecto.Query
  alias MP3Pam.Repo
  import Ecto.Changeset

  alias MP3Pam.Models.User
  alias MP3Pam.Models.Album
  alias MP3Pam.Models.Track
  alias MP3Pam.Models.Artist

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

    has_many :tracks, Track
    belongs_to :user, User
    belongs_to :artist, Artist
  end

  @doc false
  def changeset(album, attrs) do
    album
    |> cast(attrs, [:title, :hash, :cover, :img_bucket, :detail, :user_id, :artist, :release_year])
    |> validate_required([
      :title,
      :hash,
      :cover,
      :img_bucket,
      :detail,
      :user_id,
      :artist,
      :release_year
    ])
  end

  def random do
    query =
      from Album,
        order_by: fragment("RAND()"),
        limit: 1

    Repo.one(query)
  end

  def make_cover_url(%__MODULE__{} = album) do
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
