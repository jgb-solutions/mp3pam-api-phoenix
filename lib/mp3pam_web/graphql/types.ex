defmodule MP3PamWeb.GraphQL.Schema.Types do
  use Absinthe.Schema.Notation
  alias Absinthe.Blueprint.Schema
  # Object
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
    field :albums, list_of(:album)
    field :playlists, list_of(:playlist)
    field :artists, list_of(:artist)
    field :inserted_at, :naive_datetime
    field :updated_at, :naive_datetime
  end

  object :artist do
    field :id, :id
    field :name, non_null(:string)
    field :stage_name, non_null(:string)
    field :hash, non_null(:integer)
    field :poster_url, :string
    field :bio, :string
    field :tracks, list_of(:track)
    field :albums, list_of(:album)
    field :user, :user
    field :facebook_url, :string
    field :twitter_url, :string
    field :instagram_url, :string
    field :youtube_url, :string
    field :inserted_at, non_null(:naive_datetime)
    field :updated_at, non_null(:naive_datetime)
  end

  object :album do
    field :id, :id
    field :title, non_null(:string)
    field :hash, non_null(:integer)
    field :cover_url, :string
    field :detail, :string
    field :user, :user
    field :tracks, list_of(:track)
    field :artist, non_null(:artist)
    field :release_year, non_null(:integer)
    field :inserted_at, non_null(:naive_datetime)
    field :updated_at, non_null(:naive_datetime)
  end

  object :track do
    field :id, :id
    field :title, non_null(:string)
    field :hash, non_null(:integer)
    field :audio_url, non_null(:string)
    field :poster_url, :string
    field :featured, :boolean
    field :detail, :string
    field :lyrics, :string
    field :genre, non_null(:genre)
    field :artist, non_null(:artist)
    field :album, :album
    field :user, :user
    field :playlists, list_of(:playlist)
    field :number, :integer
    field :allow_download, :boolean
    field :play_count, non_null(:integer)
    field :audio_file_size, non_null(:string)
    field :download_count, non_null(:integer)
    field :inserted_at, non_null(:naive_datetime)
    field :updated_at, non_null(:naive_datetime)
  end

  object :playlist do
    field :id, :id
    field :title, non_null(:string)
    field :hash, non_null(:integer)
    field :cover_url, :string
    field :user, :user
    field :tracks, list_of(:track)
    field :inserted_at, non_null(:naive_datetime)
    field :updated_at, non_null(:naive_datetime)
  end

  object :genre do
    field :id, :id
    field :name, non_null(:string)
    field :slug, non_null(:string)
    field :tracks, :paginate_tracks
    field :inserted_at, non_null(:naive_datetime)
    field :updated_at, non_null(:naive_datetime)
  end

  object :upload_url do
    field :signed_url, non_null(:string)
    field :filename, non_null(:string)
  end

  object :login_payload do
    field :data, non_null(:user)
    field :token, non_null(:string)
  end

  # input_object
  input_object :upload_url_input do
    field :name, non_null(:string)
    field :bucket, non_null(:string)
    field :public, :boolean
    field :attachment, :boolean
  end

  input_object :order_by_input do
    field :field, non_null(:string)
    field :order, non_null(:string)
  end

  object :facebook_login_url do
    field :url, non_null(:string)
  end

  object :logout_response do
    field :success, :boolean
  end

  object :search_results do
    field :tracks, list_of(:track)
    field :artists, list_of(:artist)
    field :albums, list_of(:album)
  end

  object :paginate do
    field :pagination_info, :pagination_info
  end

  object :paginate_albums do
    import_fields(:paginate)
    field :data, list_of(:album)
  end

  object :paginate_artists do
    import_fields(:paginate)
    field :data, list_of(:artist)
  end

  object :paginate_playlists do
    import_fields(:paginate)
    field :data, list_of(:playlist)
  end

  object :paginate_tracks do
    import_fields(:paginate)
    field :data, list_of(:track)
  end

  object :paginate_users do
    import_fields(:paginate)
    field :data, list_of(:user)
  end

  object :pagination_info do
    field :current_page, :integer
    field :per_page, :integer
    field :total, :integer
    field :total_pages, :integer
    field :has_more_pages, :boolean
  end

  input_object :track_input do
    field :title, non_null(:string)
    field :audioName, non_null(:string)
    field :poster, non_null(:string)
    field :detail, :string
    field :lyrics, :string
    field :audioFileSize, non_null(:integer)
    field :artistId, non_null(:integer)
    field :genreId, non_null(:integer)
    field :img_bucket, non_null(:string)
    field :audio_bucket, non_null(:string)
    field :allowDownload, :boolean
    field :album_id, :string
    field :number, :integer
  end

  input_object :genre_input do
    field :name, non_null(:string)
  end

  input_object :add_track_to_album_input do
    field :album_id, non_null(:string)
    field :track_hash, non_null(:string)
    field :track_number, non_null(:integer)
  end

  input_object :artist_input do
    field :name, non_null(:string)
    field :stage_name, non_null(:string)
    field :poster, :string
    field :img_bucket, non_null(:string)
    field :bio, :string
    field :facebook, :string
    field :twitter, :string
    field :instagram, :string
    field :youtube, :string
  end

  input_object :album_input do
    field :title, non_null(:string)
    field :release_year, non_null(:integer)
    field :artist_id, non_null(:integer)
    field :cover, non_null(:string)
    field :detail, :string
    field :img_bucket, non_null(:string)
  end

  input_object :register_input do
    field :name, non_null(:string)
    field :email, non_null(:string)
    field :password, non_null(:string)
    field :telephone, :string
  end

  input_object :update_user_input do
    field :id, :id
    field :name, :string
    field :email, :string
    field :password, :string
    field :telephone, :string
    field :avatar, :string
    field :img_bucket, :string
  end

  input_object :login_input do
    field :email, non_null(:string)
    field :password, non_null(:string)
  end

  object :delete_album_response do
    field :success, :boolean
  end

  object :delete_track_response do
    field :success, :boolean
  end

  object :delete_artist_response do
    field :success, :boolean
  end

  object :delete_playlist_response do
    field :success, :boolean
  end

  object :delete_album_track_response do
    field :success, :boolean
  end

  object :delete_playlist_track_response do
    field :success, :boolean
  end

  object :add_track_to_album_response do
    field :success, :boolean
  end

  object :add_track_to_playlist_response do
    field :success, :boolean
  end

  object :delete_user_response do
    field :success, :boolean
  end

  object :facebook_login_payload do
    field :data, :user
    field :token, non_null(:string)
  end

  input_object :related_tracks_input do
    field :hash, non_null(:string)
    field :take, non_null(:integer)
  end

  input_object :random_artists_input do
    field :hash, non_null(:string)
    field :take, non_null(:integer)
  end

  input_object :random_albums_input do
    field :hash, non_null(:string)
    field :take, non_null(:integer)
  end

  input_object :random_playlists_input do
    field :hash, non_null(:string)
    field :take, non_null(:integer)
  end

  input_object :download_input do
    field :hash, non_null(:string)
    field :type, non_null(:string)
  end

  input_object :play_input do
    field :hash, non_null(:string)
    field :type, non_null(:string)
  end

  object :download do
    field :url, non_null(:string)
  end

  # Enum
  # enum :sort_order do
  #   value(:asc, as: "ASC")
  #   value(:desc, as: "DESC")
  # end

  enum(:sort_order, values: [:asc, :desc])
end
