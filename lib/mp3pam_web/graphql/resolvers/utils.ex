defmodule MP3PamWeb.Resolvers.Utils do
  alias MP3Pam.Repo
  import Ecto.Query
  alias MP3Pam.Models.User
  alias MP3Pam.Models.Album
  alias MP3Pam.Models.Genre
  alias MP3Pam.Models.Track
  alias MP3Pam.Models.Artist
  alias MP3Pam.Models.Playlist

  def all(_parent, _args, _resolution) do
    {:ok, Repo.all(Track)}
  end

  def find(_parent, args, _resolution) do
    {:ok, Repo.get(Track, args.id)}
  end

  # create track context user // %{context: %{current_user: user}}

  def upload_url(args, _resolution) do
    # todo
    {:ok,
     %{
       signed_url: "https://s3.upload.wasabi.com/yeah?secret=23423adfa243ksdf",
       filename: "random-file-name"
     }}
  end

  def facebook_login_url(args, _resolution) do
    # todo
    {:ok, "Yeah"}
  end

  def download(args, _resolution) do
    # todo
    {:ok, "Yeah"}
  end

  def search(args, _resolution) do
    result = Enum.map([Album, Track, Artist], fn struct ->
      do_search(struct, args.term)
    end)

    {:ok, result}
  end

  def do_search(%Album{} = struct, term) do
    query = from t in struct,
      where: like(t.title, ^term),
      select: [:id, :title]

    Repo.all(query)
  end

  def do_search(%Track{} = struct, term) do
    query = from t in struct,
      where: like(t.title, ^term),
      select: [:id, :title]

    Repo.all(query)
  end

  def do_search(%Artist{} = struct, term) do
    query = from t in struct,
      where: like(t.title, ^term),
      select: [:id, :title]

    Repo.all(query)
  end
end
