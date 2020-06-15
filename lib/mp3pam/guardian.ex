defmodule MP3Pam.Guardian do
  use Guardian, otp_app: :mp3pam
  alias MP3Pam.Models.User

  def subject_for_token(%User{} = user, _claims) do
    sub = to_string(user.id)
    {:ok, sub}
  end

  def resource_from_claims(claims) do
    user = claims["sub"] |> User.get_user!()

    {:ok, user}
  end
end
