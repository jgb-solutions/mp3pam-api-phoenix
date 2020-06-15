defmodule MP3Pam.Repo.Migrations.AddUsersTable do
  use Ecto.Migration

  def change do
    create table("users") do
      add :name, :string, null: false
      add :email, :string, size: 60, unique: true
      add :password, :string, size: 60
      add :avatar, :string
      add :fb_avatar, :string
      add :facebook_id, :string, size: 16, unique: true
      add :facebook_link, :string
      add :telephone, :string, size: 20
      add :admin, :boolean, default: false
      add :active, :boolean, default: false
      add :password_reset_code, :string
      add :first_login, :boolean, default: true
      add :img_bucket, :string
      add :token, :text

      timestamps()
    end
  end
end
