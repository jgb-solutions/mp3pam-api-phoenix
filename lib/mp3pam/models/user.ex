defmodule MP3Pam.Models.User do
  use Ecto.Schema

  schema "users" do
    field :name, :string, null: false
    field :email, :string, size: 60, unique: true
    field :password, :string, size: 60
    field :avatar, :string
    field :fb_avatar, :string
    field :facebook_id, :string, size: 16, unique: true
    field :facebook_link, :string
    field :telephone, :string, size: 20
    field :admin, :boolean, default: false
    field :active, :boolean, default: false
    field :password_reset_code, :string
    field :first_login, :boolean, default: true
    field :img_bucket, :string

    timestamps()
  end
end
