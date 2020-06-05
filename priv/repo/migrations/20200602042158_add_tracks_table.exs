defmodule MP3Pam.Repo.Migrations.AddTracksTable do
  use Ecto.Migration

  def change do
    create table("tracks") do
      add :title, :string, null: false
      add :hash, :"int(6) unsigned", unique: true, null: false
      add :audio_name, :string, null: false
      add :poster, :string, null: false
      add :img_bucket, :string, null: false
      add :audio_bucket, :string, null: false
      add :featured, :boolean, default: false
      add :detail, :text
      add :lyrics, :text
      add :audio_file_size, :string, size: 10, null: false
      add :user_id, :integer, null: false
      add :artist_id, :integer, null: false
      add :album_id, :integer
      add :genre_id, :integer, null: false
      add :number, :integer
      add :play_count, :integer, default: 0
      add :download_count, :integer, default: 0
      add :publish, :boolean, default: true
      add :allow_download, :boolean, default: false

      timestamps()
    end

    create index(:tracks, [:title])
  end
end
