import Config

secret_key_base = System.fetch_env!("SECRET_KEY_BASE")
application_port = System.fetch_env!("APP_PORT")
database_url = System.fetch_env!("DATABASE_URL")

config :mp3pam, MP3PamWeb.Endpoint,
  check_origin: false,
  http: [:inet6, port: String.to_integer(application_port)],
  secret_key_base: secret_key_base

config :mp3pam, MP3Pam.Repo,
  # ssl: true,
  url: database_url,
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")
