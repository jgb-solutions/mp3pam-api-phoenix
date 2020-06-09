defmodule MP3Pam.Models.Track do
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

  @default_poster_url "https://img-storage-prod.mp3pam.com/placeholders/track-placeholder.jpg"

  schema "tracks" do
    field :title, :string, null: false
    field :hash, :integer, unique: true, null: false
    field :audio_name, :string, null: false
    field :poster, :string, null: false
    field :img_bucket, :string, null: false
    field :audio_bucket, :string, null: false
    field :featured, :boolean, default: false
    field :detail, :string
    field :lyrics, :string
    field :audio_file_size, :string, size: 10, null: false
    # field :user_id, :integer, null: false
    # field :artist_id, :integer, null: false
    # field :album_id, :integer
    # field :genre_id, :integer, null: false
    field :number, :integer
    field :play_count, :integer, default: 0
    field :download_count, :integer, default: 0
    field :publish, :boolean, default: true
    field :allow_download, :boolean, default: false

    timestamps()

    belongs_to :user, User
    belongs_to :artist, Artist
    belongs_to :album, Album
    belongs_to :genre, Genre
    many_to_many :playlists, Playlist, join_through: "playlist_track"
  end

  def changeset(playlist, attrs) do
    playlist
    |> cast(attrs, [
      :title,
      :hash,
      :audio_name,
      :poster,
      :img_bucket,
      :audio_bucket,
      :featured,
      :detail,
      :lyrics,
      :audio_file_size,
      :user_id,
      :artist_id,
      :genre_id,
      :number,
      :play_count,
      :download_count,
      :publish,
      :allow_download
    ])
    |> validate_required([
      :title,
      :hash,
      :audio_name,
      :poster,
      :img_bucket,
      :audio_bucket,
      :audio_file_size,
      :user_id,
      :artist_id,
      :album_id,
      :genre_id
    ])
  end

  def random do
    query = from u in Track,
    order_by: fragment("RAND()"),
    limit: 1

    Repo.one(query)
  end
end
