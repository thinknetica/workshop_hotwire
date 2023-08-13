class Artist < ApplicationRecord
  has_one_attached :cover
  has_many :albums, dependent: :destroy
  has_many :tracks, through: :albums
  has_many :listenings, through: :tracks
  has_many :popular_tracks, -> { popularity_ordered.limit(10) },
    class_name: "Track",
    through: :albums,
    source: :tracks

  validates :name, presence: true, uniqueness: true

  normalizes :name, with: -> { _1.squish }

  scope :tagged, ->(tag) {
    where("EXISTS (SELECT 1 FROM json_each(artists.tags) WHERE value = ?)", tag)
  }
  scope :search, ->(q) {
    where(arel_table[:name].lower.matches("%#{q.downcase}%"))
  }
end
