defmodule MP3Pam.Models.Artist do
  use Ecto.Schema
  import Ecto.Changeset

  schema "artists" do
    field :name, :string, null: false
    field :stage_name, :string, null: false
    field :hash, :integer, unique: true, null: false
    field :poster, :string
    field :img_bucket, :string, null: false
    field :user_id, :integer
    field :bio, :string
    field :facebook, :string
    field :twitter, :string
    field :instagram, :string
    field :youtube, :string
    field :verified, :boolean, default: false
    timestamps()
  end

  @doc false
  def changeset(artist, attrs) do
    artist
    |> cast(attrs, [])
    |> validate_required([])
  end
end
