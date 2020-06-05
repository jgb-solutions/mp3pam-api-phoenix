defmodule MP3Pam.Models.Playlist do
  use Ecto.Schema
  import Ecto.Changeset

  schema "playlists" do
    field :title, :string, null: false
    field :hash, :integer, unique: true, null: false
    field :user_id, :integer

    timestamps()
  end

  @doc false
  def changeset(playlist, attrs) do
    playlist
    |> cast(attrs, [:title, :hash, :user_id])
    |> validate_required([:title, :hash, :user_id])
  end
end
