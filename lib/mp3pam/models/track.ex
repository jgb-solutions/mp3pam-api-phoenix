defmodule MP3Pam.Models.Track do
  use Ecto.Schema

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
    field :user_id, :integer, null: false
    field :artist_id, :integer, null: false
    field :album_id, :integer
    field :genre_id, :integer, null: false
    field :number, :integer
    field :play_count, :integer, default: 0
    field :download_count, :integer, default: 0
    field :publish, :boolean, default: true
    field :allow_download, :boolean, default: false

    timestamps()
  end
end
