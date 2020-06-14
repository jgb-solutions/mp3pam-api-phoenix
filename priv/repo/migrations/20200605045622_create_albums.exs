defmodule MP3Pam.Repo.Migrations.CreateAlbums do
  use Ecto.Migration

  def change do
    create table(:albums) do
      add :title, :string, null: false
      add :hash, :"int(6) unsigned", null: false
      add :cover, :string, null: false
      add :img_bucket, :string, null: false
      add :detail, :text
      add :user_id, :"int unsigned", null: false
      add :artist_id, :"int unsigned", null: false
      add :release_year, :"int(4) unsigned", null: false

      timestamps()
    end

    create index(:albums, [:title, :hash])
  end
end
