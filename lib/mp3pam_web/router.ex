defmodule MP3PamWeb.Router do
  use MP3PamWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {MP3PamWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug CORSPlug, origin: "*"
    plug :accepts, ["json"]
  end

  pipeline :graphql do
    plug MP3Pam.Context
  end

  scope "/", MP3PamWeb do
    pipe_through :browser

    live "/", PageLive, :index
  end

  # Other scopes may use custom stacks.
  # graphql_host = Application.get_env(:mp3pam, :graphql_host, "api.mp3pam.ex")
  scope "/api/graphql" do
    pipe_through :api
    pipe_through :graphql

    forward "/", Absinthe.Plug, schema: MP3PamWeb.GraphQL.Schema

    # if Mix.env() == :dev do
    #   forward "/playground", Absinthe.Plug.GraphiQL,
    #     schema: MP3PamWeb.GraphQL.Schema,
    #     interface: :playground,
    #     socket: MP3PamWeb.UserSocket
    # end
  end

  scope "/auth", MP3PamWeb do
    pipe_through :browser

    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: MP3PamWeb.Telemetry
    end
  end
end
