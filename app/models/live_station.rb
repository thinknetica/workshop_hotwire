class LiveStation < ApplicationRecord
  has_many :live_station_tracks, dependent: :destroy, inverse_of: :live_station
  has_many :tracks, -> { order(Arel.sql("live_station_tracks.position asc")) }, through: :live_station_tracks
  belongs_to :user

  has_one_attached :cover

  scope :live, -> { where(live: true) }

  def enqueue(track)
    with_lock do
      # first, remove track if already present
      tracks.delete(track)
      live_station_tracks.create!(track:, position: tracks.count)
    end
  end

  def play_now(track)
    with_lock do
      # first, remove track if already present
      tracks.delete(track)

      # Re-order the tracks
      live_station_tracks.order(position: :asc).each_with_index do |t, i|
        t.update_column(:position, i + 1) # rubocop:disable Rails/SkipsModelValidations
      end

      live_station_tracks.create!(track:, position: 0)
    end
  end

  def play_next
    live_station_tracks.order(position: :asc).first&.destroy
    current_track
  end

  def current_track = tracks.first

  def listeners_online
    Cache.store.get(listeners_key)&.to_i || 0
  end

  def update_listeners_count(count)
    Cache.store.set(listeners_key, count)
  end

  def reset_listeners_count
    Cache.store.set(listeners_key, 0)
  end

  private

  def listeners_key
    "pencil:live_station#{id}:listeners"
  end
end
