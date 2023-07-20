class Artist < ApplicationRecord
  has_one_attached :cover
  has_many :albums, dependent: :destroy
  has_many :tracks, through: :albums
  has_many :listenings, through: :tracks

  validates :name, presence: true, uniqueness: true

  normalizes :name, with: -> { _1.squish }

  scope :tagged, ->(tag) {
    where("EXISTS (SELECT 1 FROM json_each(artists.tags) WHERE value = ?)", tag)
  }
  scope :search, ->(q) {
    where(arel_table[:name].lower.matches("%#{q.downcase}%"))
  }
end
