defmodule Mp3pam.Repo do
  use Ecto.Repo,
    otp_app: :mp3pam,
    adapter: Ecto.Adapters.MyXQL
end
