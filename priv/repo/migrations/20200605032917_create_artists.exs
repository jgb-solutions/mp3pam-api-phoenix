defmodule MP3Pam.Repo.Migrations.CreateArtists do
  use Ecto.Migration

  def change do
    create table(:artists) do
      add :name, :string, null: false
      add :stage_name, :string, null: false
      add :hash, :"int(6) unsigned", unique: true, null: false
      add :poster, :string
      add :img_bucket, :string, null: false
      add :user_id, references(:users, on_delete: :nothing)
      add :bio, :text, size: 5000
      add :facebook, :string
      add :twitter, :string
      add :instagram, :string
      add :youtube, :string
      add :verified, :boolean, default: false


      timestamps()
    end
  end
end
