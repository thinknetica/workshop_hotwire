# frozen_string_literal: true

# Use inline adapter for Active Job to run jobs synchronously
Rails.application.config.active_job.queue_adapter = :inline

# Import library from db/seeds/library.json first
library = File.join(__dir__, "./seeds/library.json").then(&File.method(:read)).then(&JSON.method(:parse))

library.each do |artist_json|
  next if artist_json["albums"].empty?

  $stdout.puts "Importing artist: #{artist_json["name"]}..."

  Artist.create!(
    name: artist_json["name"],
    bio: artist_json["bio"],
    tags: artist_json["tags"] || []
  ).then do |artist|
    if artist_json.dig("image", "large")
      url = artist_json["image"]["large"]
      begin
        artist.cover.attach(io: URI.open(url), filename: "cover.#{File.extname(url).presence || ".jpg"}") # rubocop:disable Security/Open
      rescue OpenURI::HTTPError
        $stdout.puts "Failed to import cover for #{artist.name}: #{url}"
      end
    end

    artist_json["albums"].each do |album_json|
      next if album_json["tracks"].empty?

      $stdout.puts "Importing album: #{album_json["title"]}..."

      artist.albums.create(
        title: album_json["title"],
        year: album_json["year"],
        kind: album_json["kind"] || "lp"
      ).then do |album|
        if album_json.dig("image", "large")
          url = album_json["image"]["large"]
          begin
            album.cover.attach(io: URI.open(url), filename: "cover.#{File.extname(url).presence || ".jpg"}") # rubocop:disable Security/Open
          rescue OpenURI::HTTPError
            $stdout.puts "Failed to import cover for #{album.title}: #{url}"
          end
        end

        album_json["tracks"].each do |track_json|
          next if track_json["title"].blank?

          album.tracks.create(
            title: track_json["title"],
            duration: track_json["duration"],
            position: track_json["position"]
          )
        end

        $stdout.puts "Imported #{album.reload.title} with #{album.tracks_count} tracks"
      end
    end

    $stdout.puts "Imported #{artist.reload.name} with #{artist.albums_count} albums and #{artist.tracks_count} tracks"
  end
end

# Add users
password = "qwerty"

alice = User.create!(username: "alice", password:)
ivan = User.create!(username: "ivan", password:)
jack = User.create!(username: "jack", password:)

$stdout.puts "Created users: alice, ivan, jack (password: 'qwerty')"

# Generate some listening stats
alice_tracks = Track.random.limit(100)
alice_tracks.each { |track| track.listenings.create(user: alice) }

ivan_tracks = Track.random.limit(100).to_a + alice_tracks.sample(30)
ivan_tracks.each { |track| track.listenings.create(user: ivan) }

jack_tracks = Track.random.limit(200).to_a + ivan_tracks.sample(40)
jack_tracks.each { |track| track.listenings.create(user: jack) }

$stdout.puts "Seeds completed. Good luck!"
