defmodule MP3Pam.Models.Playlist do
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

  @default_poster_url "https://img-storage-prod.mp3pam.com/placeholders/playlist-placeholder.png"

  schema "playlists" do
    field :title, :string, null: false
    field :hash, :integer, unique: true, null: false
    field :cover_url, :string, virtual: true
    timestamps()

    belongs_to :user, User
    many_to_many :tracks, Track, join_through: "playlist_track"
  end

  @doc false
  def changeset(playlist, attrs) do
    playlist
    |> cast(attrs, [:title, :hash, :user_id])
    |> validate_required([:title, :hash, :user_id])
  end

  def random do
    query = from Playlist,
    order_by: fragment("RAND()"),
    limit: 1

    Repo.one(query)
  end

  def make_cover_url(%__MODULE__{} = playlist) do
    if length(playlist.tracks) > 0 do
      Track.make_poster_url(List.first(playlist.tracks))
    else
      @default_poster_url
    end
  end

  def with_cover_url(%__MODULE__{} = playlist) do
    %{playlist | cover_url: make_cover_url(playlist)}
  end
end
