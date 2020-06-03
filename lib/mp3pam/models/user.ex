defmodule MP3Pam.Models.User do
  use Ecto.Schema

  schema "users" do
    field :name, :string
    field :email, :string
    field :password, :string
    field :avatar, :string
    field :fb_avatar, :string
    field :facebook_id, :string
    field :facebook_link, :string
    field :telephone, :string
    field :admin, :boolean, default: false
    field :active, :boolean, default: false
    field :password_reset_code, :string
    field :first_login, :boolean, default: true
    field :img_bucket, :string
    timestamps()
  end
end
