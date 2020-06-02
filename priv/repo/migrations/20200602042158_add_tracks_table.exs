defmodule MP3Pam.Repo.Migrations.AddTracksTable do
  use Ecto.Migration

  def change do
    create table("tracks") do
      add :title, :string
      add :hash, :integer
      add :audio_name, :string
      add :poster, :string
      add :img_bucket, :string
      add :audio_bucket, :string
      add :featured, :boolean, default: false
      add :lyrics, :text
      add :audio_file_size, :string, size: 10
      add :user_id, :integer
      add :artist_id, :integer
      add :album_id, :integer
      add :genre_id, :integer
      add :number, :integer
      add :play_count, :integer, default: 0
      add :download_count, :integer, default: 0
      add :publish, :boolean, default: true
      add :allow_download, :boolean, default: false
    end
  end
end
