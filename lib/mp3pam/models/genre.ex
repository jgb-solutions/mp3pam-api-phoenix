defmodule MP3Pam.Models.Genre do
  use Ecto.Schema
  import Ecto.Changeset

  schema "genres" do
    field :name, :string
    field :slug, :string

    timestamps()
  end

  @doc false
  def changeset(genre, attrs) do
    genre
    |> cast(attrs, [:name, :slug])
    |> validate_required([:name, :slug])
  end
end
