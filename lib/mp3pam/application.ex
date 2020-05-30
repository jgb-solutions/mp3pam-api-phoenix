defmodule Mp3pam.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Mp3pam.Repo,
      # Start the Telemetry supervisor
      Mp3pamWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Mp3pam.PubSub},
      # Start the Endpoint (http/https)
      Mp3pamWeb.Endpoint
      # Start a worker by calling: Mp3pam.Worker.start_link(arg)
      # {Mp3pam.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Mp3pam.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    Mp3pamWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
