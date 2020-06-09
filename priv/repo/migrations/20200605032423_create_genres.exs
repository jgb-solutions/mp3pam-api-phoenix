defmodule MP3Pam.Repo.Migrations.CreateGenres do
  use Ecto.Migration

  def change do
    create table(:genres) do
      add :name, :string, null: false, unique: true
      add :slug, :string, null: false, unique: true

      timestamps()
    end
  end
end
