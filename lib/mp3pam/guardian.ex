defmodule MP3Pam.Guardian do
  use Guardian, otp_app: :mp3pam
  alias MP3Pam.Models.User

  def subject_for_token(%User{} = user, _claims) do
    {:ok, to_string(user.id)}
  end

  def resource_from_claims(%{"sub" => id}) do
    user = User.get_user!(id)

    {:ok, user}
  rescue
    Ecto.NoResultsError -> {:error, :"dUser not foun", code: 404}
  end
end
