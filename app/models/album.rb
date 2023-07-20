class Album < ApplicationRecord
  has_one_attached :cover
  has_many :tracks, dependent: :destroy, inverse_of: :album
  has_many :listenings, through: :tracks

  belongs_to :artist, counter_cache: true

  enum :kind, {lp: "lp", ep: "ep", live: "live", compilation: "compilation"}

  validates :title, presence: true

  normalizes :title, with: -> { _1.squish }

  scope :search, ->(q) {
    where(arel_table[:title].lower.matches("%#{q.downcase}%"))
  }
end
