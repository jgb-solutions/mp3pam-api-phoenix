defmodule MP3PamWeb.Resolvers.Utils do
  alias MP3Pam.Repo
  alias MP3Pam.Models.Track

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
    # todo
    {:ok, "Yeah"}
  end


end
