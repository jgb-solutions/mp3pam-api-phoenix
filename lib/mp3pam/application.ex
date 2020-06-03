defmodule MP3Pam.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      MP3Pam.Repo,
      # Start the Telemetry supervisor
      MP3PamWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: MP3Pam.PubSub},
      # Start the Endpoint (http/https)
      MP3PamWeb.Endpoint,
      # Start a worker by calling: MP3Pam.Worker.start_link(arg)
      # {MP3Pam.Worker, arg}
      {Absinthe.Subscription, MP3PamWeb.Endpoint}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MP3Pam.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    MP3PamWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
