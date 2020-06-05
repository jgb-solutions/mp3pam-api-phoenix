defmodule MP3Pam.Models.Album do
  use Ecto.Schema
  import Ecto.Changeset

  schema "albums" do
    field :artist_id, :integer
    field :cover, :string
    field :detail, :string
    field :hash, :integer
    field :img_bucket, :string
    field :release_year, :integer
    field :title, :string
    field :user_id, :integer

    timestamps()
  end

  @doc false
  def changeset(album, attrs) do
    album
    |> cast(attrs, [:title, :hash, :cover, :img_bucket, :detail, :user_id, :artist_id, :release_year])
    |> validate_required([:title, :hash, :cover, :img_bucket, :detail, :user_id, :artist_id, :release_year])
  end
end
