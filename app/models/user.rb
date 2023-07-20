class User < ApplicationRecord
  has_secure_password

  has_many :listenings, dependent: :destroy, inverse_of: :user
  has_many :recent_tracks, -> { order(Listening.arel_table[:created_at].desc) }, through: :listenings, source: :track
  has_many :recent_albums, -> { order(Listening.arel_table[:created_at].desc) }, through: :recent_tracks, source: :album

  validates :username, presence: true, uniqueness: true
  validates :password, allow_nil: true, length: {minimum: 6}

  PREFIX = "@"
end
