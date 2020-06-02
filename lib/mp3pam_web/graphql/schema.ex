defmodule MP3PamWeb.Schema do
  use Absinthe.Schema
  import_types(MP3PamWeb.Schema.Types)

  query do
    @desc "Get all users"
    field :users, list_of(:user) do
      resolve(&MP3PamWeb.Resolvers.User.all/3)
    end

    @desc "Get all tracks"
    field :tracks, list_of(:track) do
      resolve(&MP3PamWeb.Resolvers.Track.all/3)
    end

    field :user, :user do
      arg(:id, non_null(:id))
      resolve(&MP3PamWeb.Resolvers.User.find/3)
    end

    # field :blog_post, type: :blog_post do
    #   arg(:id, non_null(:id))
    #   resolve(&MP3PamWeb.Blog.PostResolver.find/2)
    # end

    # field :accounts_users, list_of(:accounts_user) do
    #   resolve(&MP3PamWeb.Accounts.UserResolver.all/2)
    # end

    # field :accounts_user, :accounts_user do
    #   arg(:email, non_null(:string))
    #   resolve(&MP3PamWeb.Accounts.UserResolver.find/2)
    # end

    # mutation do
    #   field :create_post, type: :blog_post do
    #     arg(:title, non_null(:string))
    #     arg(:body, non_null(:string))
    #     arg(:accounts_user_id, non_null(:id))

    #     resolve(&MP3PamWeb.Blog.PostResolver.create/2)
    #   end

    #   field :update_post, type: :blog_post do
    #     arg(:id, non_null(:id))
    #     arg(:post, :update_post_params)

    #     resolve(&MP3PamWeb.Blog.PostResolver.update/2)
    #   end

    #   field :delete_post, type: :blog_post do
    #     arg(:id, non_null(:id))
    #     resolve(&MP3PamWeb.Blog.PostResolver.delete/2)
    #   end
    # end
  end

  # mutation do
  # end

  # subscription do
  # end
end
