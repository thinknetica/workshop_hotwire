class Listening < ApplicationRecord
  belongs_to :user
  belongs_to :track, counter_cache: true

  after_create do
    Album.increment_counter(:listenings_count, track.album_id) # rubocop:disable Rails/SkipsModelValidations
    Artist.increment_counter(:listenings_count, track.album.artist_id) # rubocop:disable Rails/SkipsModelValidations
  end

  after_destroy do
    Album.decrement_counter(:listenings_count, track.album_id) # rubocop:disable Rails/SkipsModelValidations
    Artist.decrement_counter(:listenings_count, track.album.artist_id) # rubocop:disable Rails/SkipsModelValidations
  end
end
