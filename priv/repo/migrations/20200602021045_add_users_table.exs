defmodule MP3Pam.Repo.Migrations.AddUsersTable do
  use Ecto.Migration

  def change do
    create table("users") do
      add :name, :string
      add :email, :string
      add :password, :string
      add :avatar, :string
      add :fb_avatar, :string
      add :facebook_id, :string
      add :facebook_link, :string
      add :telephone, :string
      add :admin, :boolean, default: false
      add :active, :boolean, default: false
      add :password_reset_code, :string
      add :first_login, :boolean, default: true
      add :img_bucket, :string

      timestamps()
    end
  end

  #  def up do
  #   create table("weather") do
  #     add :city,    :string, size: 40
  #     add :temp_lo, :integer
  #     add :temp_hi, :integer
  #     add :prcp,    :float

  #     timestamps()
  #   end
  # end

  # def down do
  #   drop table("weather")
  # end
end
