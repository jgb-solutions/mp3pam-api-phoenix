defmodule MP3Pam.Models.Track do
  use Ecto.Schema

  schema "tracks" do
    field :title, :string
    field :hash, :integer
    field :audio_name, :string
    field :poster, :string
    field :img_bucket, :string
    field :audio_bucket, :string
    field :featured, :boolean, default: false
    field :lyrics, :string
    field :audio_file_size, :string, size: 10
    field :user_id, :integer
    field :artist_id, :integer
    field :album_id, :integer
    field :genre_id, :integer
    field :number, :integer
    field :play_count, :integer, default: 0
    field :download_count, :integer, default: 0
    field :publish, :boolean, default: true
    field :allow_download, :boolean, default: false
  end
end
