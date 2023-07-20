class User < ApplicationRecord
  has_secure_password

  has_many :listenings, dependent: :destroy, inverse_of: :user
  has_many :recent_tracks, -> { order(Listening.arel_table[:created_at].desc) }, through: :listenings, source: :track
  has_many :recent_albums, -> { order(Listening.arel_table[:created_at].desc) }, through: :recent_tracks, source: :album
  has_one :live_station, inverse_of: :user, dependent: :destroy

  validates :username, presence: true, uniqueness: true
  validates :password, allow_nil: true, length: {minimum: 6}

  PREFIX = "@"

  def build_live_station(params = {})
    params[:name] ||= "#{User::PREFIX}#{username}'s Station"
    super(params)
  end

  def live_station! = live_station || build_live_station.tap(&:save!)
end
