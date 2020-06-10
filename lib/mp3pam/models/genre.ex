defmodule MP3Pam.Models.Genre do
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

  schema "genres" do
    field :name, :string, unique: true
    field :slug, :string, unique: true

    timestamps()

    has_many :tracks, Track
  end

  @doc false
  def changeset(genre, attrs) do
    genre
    |> cast(attrs, [:name, :slug])
    |> validate_required([:name, :slug])
  end

  def random do
    query = from Genre,
    order_by: fragment("RAND()"),
    limit: 1

    Repo.one(query)
  end
end
