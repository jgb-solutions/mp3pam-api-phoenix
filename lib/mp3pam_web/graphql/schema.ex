defmodule MP3PamWeb.GraphQL.Schema do
  use Absinthe.Schema
  import_types(Absinthe.Type.Custom)
  import_types(MP3PamWeb.GraphQL.Schema.Types)
  # import MP3Pam.GraphQL.Macro

  query do
    # Protected Query
    field :me, non_null(:user) do
      resolve(&MP3PamWeb.Resolvers.User.me/2)
    end

    field :upload_url, non_null(:upload_url) do
      arg(:input, non_null(:upload_url_input))
      resolve(&MP3PamWeb.Resolvers.Utils.upload_url/2)
    end

    # Non-protected query
    field :login, :login_payload do
      arg(:input, non_null(:login_input))
      resolve(&MP3PamWeb.Resolvers.Auth.login/2)
    end

    # Tracks
    @desc "Get all tracks"
    field :tracks, :paginate_tracks do
      arg(:page, :integer)
      arg(:take, :integer)
      arg(:order_by, list_of(:order_by_input))

      resolve(&MP3PamWeb.Resolvers.Track.paginate/2)
    end

    field :tracks_by_genre, :paginate_tracks do
      arg(:page, :integer)
      arg(:take, :integer)
      arg(:order_by, list_of(:order_by_input))
      arg(:slug, non_null(:string))

      resolve(&MP3PamWeb.Resolvers.Track.tracks_by_genre/2)
    end

    field :related_tracks, list_of(:track) do
      arg(:input, non_null(:related_tracks_input))

      resolve(&MP3PamWeb.Resolvers.Track.related_tracks/2)
    end

    field :track, :track do
      arg(:hash, non_null(:string))

      resolve(&MP3PamWeb.Resolvers.Track.find_by_hash/2)
    end

    # Playlists
    field :playlists, :paginate_playlists do
      arg(:page, :integer)
      arg(:take, :integer)
      arg(:order_by, list_of(:order_by_input))

      # hasTracks
      resolve(&MP3PamWeb.Resolvers.Playlist.paginate/2)
    end

    field :playlist, :playlist do
      arg(:hash, non_null(:string))
      resolve(&MP3PamWeb.Resolvers.Playlist.find_by_hash/2)
    end

    field :random_playlists, :paginate_playlists do
      arg(:input, non_null(:random_playlists_input))
      resolve(&MP3PamWeb.Resolvers.Playlist.random_playlists/2)
    end

    # Users
    field :users, :paginate_users do
      arg(:page, :integer)
      arg(:take, :integer)
      arg(:order_by, list_of(:order_by_input))

      resolve(&MP3PamWeb.Resolvers.User.paginate/2)
    end

    field :user, :user do
      arg(:id, non_null(:id))

      resolve(&MP3PamWeb.Resolvers.User.find/2)
    end

    # Genres
    field :genres, list_of(:genre) do
      resolve(&MP3PamWeb.Resolvers.Genre.all/2)
    end

    field :genre, :genre do
      arg(:slug, non_null(:string))

      resolve(&MP3PamWeb.Resolvers.Genre.find_by_slug/2)
    end

    # Artists
    field :artists, :paginate_artists do
      arg(:page, :integer)
      arg(:take, :integer)
      arg(:order_by, list_of(:order_by_input))

      resolve(&MP3PamWeb.Resolvers.Artist.paginate/2)
    end

    field :artist, :artist do
      arg(:hash, non_null(:string))

      resolve(&MP3PamWeb.Resolvers.Artist.find_by_hash/2)
    end

    field :random_artists, :paginate_artists do
      arg(:input, non_null(:random_artists_input))

      resolve(&MP3PamWeb.Resolvers.Artist.random_artists/2)
    end

    # Albums
    field :albums, :paginate_albums do
      arg(:page, :integer)
      arg(:take, :integer)
      arg(:order_by, list_of(:order_by_input))

      # hasTracks
      resolve(&MP3PamWeb.Resolvers.Album.paginate/2)
    end

    field :album, :album do
      arg(:hash, non_null(:string))

      resolve(&MP3PamWeb.Resolvers.Album.find_by_hash/2)
    end

    field :random_albums, list_of(:album) do
      arg(:input, non_null(:random_albums_input))

      resolve(&MP3PamWeb.Resolvers.Album.random_albums/2)
    end

    # Facebook Login URL
    field :facebook_login_url, non_null(:facebook_login_url) do
      resolve(&MP3PamWeb.Resolvers.Utils.facebook_login_url/2)
    end

    field :download, non_null(:download) do
      arg(:input, non_null(:download_input))

      resolve(&MP3PamWeb.Resolvers.Utils.download/2)
    end

    field :search, non_null(:search_results) do
      arg(:query, non_null(:string))

      resolve(&MP3PamWeb.Resolvers.Utils.search/2)
    end
  end

  mutation do
    # Protected Mutations
    @desc "Create a user"
    field :create_user, type: :user do
      arg(:name, non_null(:string))
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))
      arg(:telephone, :string)

      resolve(&MP3PamWeb.Resolvers.User.create_user/2)
    end

    # Auth
    field :logout, non_null(:logout_response) do
      resolve(&MP3PamWeb.Resolvers.Auth.logout/2)
    end

    # Users
    field :update_user, non_null(:user) do
      arg(:input, non_null(:update_user_input))
      resolve(&MP3PamWeb.Resolvers.User.update_user/2)
    end

    field :delete_user, non_null(:delete_user_response) do
      arg(:id, non_null(:id))

      resolve(&MP3PamWeb.Resolvers.User.delete_user/2)
    end

    # Tracks
    field :add_track, non_null(:track) do
      arg(:input, non_null(:track_input))

      resolve(&MP3PamWeb.Resolvers.Track.add_track/2)
    end

    field :delete_track, non_null(:delete_track_response) do
      arg(:hash, non_null(:string))

      resolve(&MP3PamWeb.Resolvers.Track.delete_track/2)
    end

    # Genres
    field :add_genre, non_null(:genre) do
      arg(:input, non_null(:genre_input))

      resolve(&MP3PamWeb.Resolvers.Genre.add_genre/2)
    end

    # Artists
    field :add_artist, non_null(:artist) do
      arg(:input, non_null(:artist_input))

      resolve(&MP3PamWeb.Resolvers.Artist.add_artist/2)
    end

    field :delete_artist, non_null(:delete_artist_response) do
      arg(:hash, non_null(:string))

      resolve(&MP3PamWeb.Resolvers.Artist.delete_artist/2)
    end

    # Albums
    field :create_album, non_null(:album) do
      arg(:input, non_null(:album_input))

      resolve(&MP3PamWeb.Resolvers.Album.create_album/2)
    end

    field :delete_album, non_null(:delete_album_response) do
      arg(:hash, non_null(:string))

      resolve(&MP3PamWeb.Resolvers.Album.delete_album/2)
    end

    field :delete_album_track, non_null(:delete_album_track_response) do
      arg(:hash, non_null(:string))

      resolve(&MP3PamWeb.Resolvers.Album.delete_album_track/2)
    end

    field :add_track_to_album, non_null(:add_track_to_album_response) do
      arg(:input, non_null(:add_track_to_album_input))

      resolve(&MP3PamWeb.Resolvers.Album.add_track_to_album/2)
    end

    # Playlists
    field :delete_playlist, non_null(:delete_playlist_response) do
      arg(:hash, non_null(:string))

      resolve(&MP3PamWeb.Resolvers.Playlist.delete_playlist/2)
    end

    field :delete_playlist_track, non_null(:delete_playlist_track_response) do
      arg(:track_hash, non_null(:string))
      arg(:playlist_hash, non_null(:string))

      resolve(&MP3PamWeb.Resolvers.Playlist.delete_playlist_hash/2)
    end

    field :add_track_to_playlist, non_null(:add_track_to_playlist_response) do
      arg(:track_hash, non_null(:string))
      arg(:playlist_hash, non_null(:string))

      resolve(&MP3PamWeb.Resolvers.Playlist.add_track_to_playlist/2)
    end

    field :create_playlist, non_null(:playlist) do
      arg(:title, non_null(:string))

      resolve(&MP3PamWeb.Resolvers.Playlist.create_playlist/2)
    end

    # Play/Download stats
    field :update_download_count, :boolean do
      arg(:input, non_null(:download_input))

      resolve(&MP3PamWeb.Resolvers.Util.update_download_count/2)
    end

    field :update_play_count, :boolean do
      arg(:input, non_null(:play_input))

      resolve(&MP3PamWeb.Resolvers.Utils.update_play_count/2)
    end

    # Non-protected Mutations
    # Auth
    field :register, :user do
      arg(:input, non_null(:register_input))

      resolve(&MP3PamWeb.Resolvers.Auth.register/2)
    end

    field :handle_facebook_connect, non_null(:facebook_login_payload) do
      arg(:code, non_null(:string))

      resolve(&MP3PamWeb.Resolvers.Utils.handle_facebook_connect/2)
    end
  end

  subscription do
    field :track_added, :track do
      arg(:repo_name, non_null(:string))

      # The topic function is used to determine what topic a given subscription
      # cares about based on its arguments. You can think of it as a way to tell the
      # difference between
      # subscription {
      #   trackAdded(repoName: "absinthe-graphql/absinthe") { content }
      # }
      #
      # and
      #
      # subscription {
      #   trackAdded(repoName: "elixir-lang/elixir") { content }
      # }
      #
      # If needed, you can also provide a list of topics:
      #   {:ok, topic: ["absinthe-graphql/absinthe", "elixir-lang/elixir"]}
      config(fn args, _ ->
        {:ok, topic: args.repo_name}
      end)

      # this tells Absinthe to run any subscriptions with this field every time
      # the :submit_track mutation happens.
      # It also has a topic function used to find what subscriptions care about
      # this particular track
      trigger(:submit_track,
        topic: fn track ->
          track.repository_name
        end
      )

      resolve(fn track, _, _ ->
        # this function is often not actually necessary, as the default resolver
        # for subscription functions will just do what we're doing here.
        # The point is, subscription resolvers receive whatever value triggers
        # the subscription, in our case a track.
        {:ok, track}
      end)
    end
  end
end
