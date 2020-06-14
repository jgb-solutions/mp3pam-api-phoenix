defmodule MP3Pam.Repo.Migrations.CreatePlaylists do
  use Ecto.Migration

  def change do
    create table(:playlists) do
      add :title, :string, null: false
      add :hash, :"int(6) unsigned", unique: true, null: false
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(:playlists, [:title, :hash])
  end
end
