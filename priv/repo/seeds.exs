alias MP3Pam.Repo
alias MP3Pam.Utils
alias MP3Pam.Models.User
alias MP3Pam.Models.Album
alias MP3Pam.Models.Genre
alias MP3Pam.Models.Track
alias MP3Pam.Models.Artist
alias MP3Pam.Models.Playlist

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
];

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
];
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

  Enum.each(1..50, fn _i ->
    username = Faker.Internet.user_name()

    Repo.insert!(%Artist{
      name: Faker.Name.name(),
      stage_name: Faker.Name.name(),
      poster: "artists/" <> Enum.random(artist_posters),
      hash: Utils.getHash(Artist),
      user_id: Repo.one!(User).id,
      bio: Faker.Lorem.paragraph(),
      facebook: username,
      twitter: username,
      youtube: username,
      instagram: username,
      img_bucket: "img-storage-dev.mp3pam.com",
    })
  end)
  IO.puts("Artists table seeded!")

  # $this->call(AlbumsTableSeeder::class)
  # IO.puts("Albums table seeded!")

  # $this->call(TracksTableSeeder::class)
  # IO.puts("Tracks table seeded!")

  # $this->call(PlaylistsTableSeeder::class)
  # IO.puts("Playlists table seeded!")

  # $this->call(PlaylistTrackTableSeeder::class)
  # IO.puts("PlaylistTrack table seeded!")
end
