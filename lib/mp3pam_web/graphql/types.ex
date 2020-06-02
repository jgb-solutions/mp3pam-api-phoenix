defmodule MP3PamWeb.Schema.Types do
  use Absinthe.Schema.Notation

  object :user do
    field :id, :id
    field :name, :string
    field :email, :string
    field :avatar, :string
    field :fb_avatar, :string
    field :facebook_id, :string
    field :facebook_link, :string
    field :telephone, :string
    field :admin, :boolean
    field :active, :boolean
    field :first_login, :boolean
    field :img_bucket, :string
    field :tracks, list_of(:track)
  end

  object :track do
    field :id, :id
    field :title, :string
    field :hash, :integer
    field :audio_name, :string
    field :poster, :string
    field :img_bucket, :string
    field :audio_bucket, :string
    field :featured, :boolean
    field :lyrics, :string
    field :audio_file_size, :string
    field :user_id, :integer
    field :artist_id, :integer
    field :album_id, :integer
    field :genre_id, :integer
    field :number, :integer
    field :play_count, :integer
    field :download_count, :integer
    field :publish, :boolean
    field :allow_download, :boolean
  end
end
