defmodule MP3Pam.Repo do
  use Ecto.Repo,
    otp_app: :mp3pam,
    adapter: Ecto.Adapters.MyXQL

  use Scrivener, page_size: 20
end
