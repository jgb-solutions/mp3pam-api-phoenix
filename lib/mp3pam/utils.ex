defmodule MP3Pam.Utils do
  alias MP3Pam.Repo

  def getHash(struct) do
    hash = Enum.random(111111..999999)

    case Repo.get_by(struct, hash: hash) do
      %struct{} ->
        getHash(struct)
      nil ->
        hash
    end
  end
end
