alias MP3Pam.Repo
alias MP3Pam.Utils
alias MP3Pam.Models.User
alias MP3Pam.Models.Album
alias MP3Pam.Models.Genre
alias MP3Pam.Models.Track
alias MP3Pam.Models.Artist
alias MP3Pam.Models.Playlist

artist_posters = [
  "p06b4ktw.jpg", "_2Xp8Hde_400x400.png", "p01bqgmc.jpg",
  "p05kdhc3.jpg", "256x256.jpg", "GettyImages-521943452-e1527600573393-256x256.jpg",
  "oU7C04AF_400x400.jpg", "SM9t8paa_400x400.jpg", "p01br7j4.jpg",
  "181121-Daly-Tekashi-6ix9ine-tease_wpljyq.jpeg", "256.jpg", "p023cxqn.jpg",
  "p01bqlzy.jpg", "culture1.jpg", "Tyga-Molly-256x256.jpg",
  "GettyImages-599438124-256x256.jpg", "bLVTjpR4_400x400.jpg", "p01br530.jpg",
  "Kfd0NPizaV8FW0vyIBzHn_xs822K-jHgxZYT-S7Znmc.jpg", "55973d5d0a44d8d36a8b09607abbf70a.jpg",
  "GettyImages-2282702_l75xht (1).jpeg", "p01br58s.jpg", "p049twzl.jpg", "247664528009202.jpg",
]

genres = [
  "Compas (Konpa)",
  "Roots (Rasin)",
  "Reggae",
  "Yanvalou",
  "R&B",
  "Rap",
  "Rap Kreyòl",
  "Dancehall",
  "Other",
  "Carnival",
  "Gospel",
  "DJ",
  "Mixtape",
  "Rabòday",
  "Rara",
  "Reggaeton",
  "House",
  "Jazz",
  "Raga",
  "Soul",
  "Sanba",
  "Sanmba",
  "Rock & Roll",
  "Techno",
  "Slow",
  "Salsa",
  "Troubadour",
  "Riddim",
  "Afro",
  "Slam"
]

album_covers = [
  "images.jpeg", "180408-stereo-williams-cardi-b-hero_es4khm.jpeg",
  "kendrick-lamar-damn.-album-artwork.jpg",
  "2109c873c3f33ea6dfe2ca6842881c3a.jpg",
  "everybody-s-something.jpg", "e6eddf74f552b58f044564937c4d03f7.jpg",
  "p01jq74x.jpg", "Birdman_and_Lil_Wayne_Leather_So_Soft.jpg",
  "51+Cgm4HBUL._AA256_.jpg", "d03ffbb2-4558-4ffe-846f-62d58ab2d3a2.jpg",
  "YT-Drumma-Boy-256x256.jpg", "mkrmvba8-7903915.jpg",
  "2pac_instrumentals-rap-revolution_2.jpg", "UserAvatar.jpg",
  "itchHR-1-256x256.jpg", "41j0zn-UXnL._AA256_.jpg",
  "3d6c58c6-4572-4c72-a6e6-63b0f5d0b446.jpg", "p02lppdp.jpg",
]

track_posters = [
  "cover256x256-558f05a20d704c239b77f8d806886464.jpg",
  "cover256x256-4de6dd257b8347e7bebe00b3b4630b71.jpg",
  "cover256x256-bd6bca6cfcae4825ab8e40ff2ea89596.jpg",
  "3ded8e0edc080f07a3a80ba5354d3ee7.jpg",
  "cover256x256-b82dac25a8fc4522b5cee417c8f9c414.jpg",
  "cover256x256-69a4662389e44c9e8f13b1ae8868d9b7.jpg",
  "cover256x256-3786d418d27f41378cb17b94a1890a50.jpg",
  "cover256x256-a97367ecb2c44ced9f722edd7c37414b.jpg",
  "cover256x256-7b82a27d2bf94279800b5d1f1e4077c4.jpg",
  "cover256x256-888b684ae24d47b79f4f55d66dc8cb40.jpg",
  "51ri1Ho8s5L._AA256_.jpg",
  "cover256x256-e3f35413861645bf921926f04fdd7499.jpg",
  "cover256x256-26048aee74bc4dc7b21a9a02295ad546.jpg",
  "a327310e6620b5f6d6dc3c0875d8b528.jpg",
  "0ba78f0b96c90599c04693c1faed92c7.jpg",
  "weebie.jpeg", "cover256x256-2df51bf5cf51437691ed27ca7e1981df.jpg",
  "apa7remqyqce2xx87c18.jpeg", "5820f738b9bdcdcde097aa9334e5c00a.jpg",
  "616j6KySGPL._AA256_.jpg", "1357828077_uploaded.jpg", "download3.jpeg",
  "Pu5fUTwO_400x400.jpg", "image.jpg",
]

audios = [
  "Always On My Mind.mp3",
  "Chris_Brown_-_Fallen_Angel_(mp3.pm).mp3",
  "DANOLA premye fwa.mp3",
  "Daville_-_Mirrors_(mp3.pm).mp3",
  "Gym Class Heroes ft. Adam Levine - Stereo Hearts.mp3",
  "Jason Derulo - It Girl.mp3",
  "OMVR-Bad-News.mp3",
  "Pierre Jean - Krèy.mp3",
  "Pierre Jean - Peye Pote.mp3",
  "T-Vice - San Limit Ringtone.mp3",
]

# Users
Repo.delete_all(User)
users = [
  %{
    name: "Jean Gérard",
    email: "jgbneatdesign@gmail.com",
    password: "asdf,,,",
    admin: true,
    telephone: "41830318",
  }
]

Enum.each(users, fn user ->
  Repo.insert!(%User{
    name: user.name,
    email: user.email,
    password: user.password,
    admin: user.admin,
    telephone: user.telephone
  })
end)
IO.puts("Users table seeded!")

# Genres
Repo.delete_all(Genre)
Enum.each(genres, fn genre ->
  Repo.insert!(%Genre{
    name: genre,
    slug: Slugger.slugify_downcase(genre)
  })
end)
IO.puts("Genres table seeded!")

if Mix.env() == :dev do
  # Artists
  Repo.delete_all(Artist)
  Enum.each(1..100, fn _i ->
    username = Faker.Internet.user_name()

    Repo.insert!(%Artist{
      name: Faker.Name.name(),
      stage_name: Faker.Name.name(),
      poster: "artists/" <> Enum.random(artist_posters),
      hash: Utils.getHash(Artist),
      user_id: User.random().id,
      bio: Faker.Lorem.paragraph(),
      facebook: username,
      twitter: username,
      youtube: username,
      instagram: username,
      img_bucket: "img-storage-dev.mp3pam.com",
    })
  end)
  IO.puts("Artists table seeded!")

    # Albums
    Repo.delete_all(Album)
    Enum.each(1..100, fn _i ->
      Repo.insert!(%Album{
        title: Faker.Name.name(),
        detail: Faker.Lorem.paragraph(5),
        cover: "albums/" <> Enum.random(album_covers),
        hash: Utils.getHash(Album),
        user_id: User.random().id,
        artist_id: Artist.random().id,
        img_bucket: "img-storage-dev.mp3pam.com",
        release_year: Enum.random(1950..2019),
        # inserted_at: $inserted_at,
        # updated_at: $updated_at,
      })
    end)
    IO.puts("Albums table seeded!")

  # Track
  Repo.delete_all(Track)
  Enum.each(1..500, fn _i ->
    Repo.insert!(%Track{
      title: Faker.Name.name(),
      hash: Utils.getHash(Track),
      detail: Faker.Lorem.paragraph(5),
      lyrics: Faker.Lorem.paragraph(5),
      audio_file_size: Integer.to_string(Enum.random(10000..99999)),
      audio_name: "demo/" <> Enum.random(audios),
      poster: "tracks/" <> Enum.random(track_posters),
      user_id: User.random().id,
      artist_id: Artist.random().id,
      genre_id: Genre.random().id,
      album_id: Album.random().id,
      number: Enum.random(00..99),
      img_bucket: "img-storage-dev.mp3pam.com",
      audio_bucket: "audio-storage-dev.mp3pam.com",
      allow_download: true,
      # inserted_at: $inserted_at,
      # updated_at: $updated_at,
    })
  end)
  IO.puts("Track table seeded!")

  # Playlists
  Repo.delete_all(Playlist)
  Enum.each(1..100, fn _i ->
    Repo.insert!(%Playlist{
      title: Faker.Name.name(),
      hash: Utils.getHash(Playlist),
      user_id: User.random().id,
      # inserted_at: $inserted_at,
      # updated_at: $updated_at,
    })
  end)
  IO.puts("Playlists table seeded!")

    # PlayListTrack
    Repo.delete_all("playlist_track")
    Repo.insert_all(
      "playlist_track",
      Enum.map(1..500, fn _i ->
        [
          track_id: Track.random().id,
          playlist_id: Playlist.random().id,
          inserted_at: ~N[2020-06-07 11:04:35],
          updated_at: ~N[2020-06-07 11:04:35],
        ]
      end)
    )
    IO.puts("PlayListTrack table seeded!")
end
