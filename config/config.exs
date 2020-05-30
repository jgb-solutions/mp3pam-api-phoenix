# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :mp3pam,
  ecto_repos: [Mp3pam.Repo]

# Configures the endpoint
config :mp3pam, Mp3pamWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "4ZEeAMNBIt7WkC3b58RCC7t7KKYHxZmUNhPnGYJ5zQSxfcwjpdgEf/itfuCPQS89",
  render_errors: [view: Mp3pamWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Mp3pam.PubSub,
  live_view: [signing_salt: "iOCiRTlm"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
