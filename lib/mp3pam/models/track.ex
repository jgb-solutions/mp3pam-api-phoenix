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
    field :number, :integer
    field :play_count, :integer, default: 0
    field :download_count, :integer, default: 0
    field :publish, :boolean, default: true
    field :allow_download, :boolean, default: false
    field :poster_url, :string, virtual: true
    field :audio_url, :string, virtual: true

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
    query =
      from Track,
        order_by: fragment("RAND()"),
        limit: 1

    Repo.one(query)
  end

  def make_poster_url(%__MODULE__{} = track) do
    if track.poster do
      "https://" <> track.img_bucket <> "/" <> track.poster
    else
      @default_poster_url
    end
  end

  def with_poster_url(%__MODULE__{} = track) do
    %{track | poster_url: make_poster_url(track)}
  end

  def make_audio_url(%__MODULE__{} = track) do
    {:ok, url} =
      ExAws.Config.new(:s3)
      |> ExAws.S3.presigned_url(
        :get,
        track.audio_bucket,
        track.audio_name,
        expires_in: 7 * 24 * 60 * 60,
        query_params: [
          cache_control: "max-age=86400"
        ]
      )

    url
  end

  def with_audio_url(%__MODULE__{} = track) do
    %{track | audio_url: make_audio_url(track)}
  end
end
