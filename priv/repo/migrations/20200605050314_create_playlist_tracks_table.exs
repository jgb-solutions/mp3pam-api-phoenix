defmodule MP3Pam.Repo.Migrations.CreatePlaylistTracksTable do
  use Ecto.Migration

  def change do
    create table("playlist_track") do
      add :playlist_id, :"int unsigned", null: false
      add :track_id, :"int unsigned", null: false

      timestamps()
    end
  end
end
