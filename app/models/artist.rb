class Artist < ApplicationRecord
  has_one_attached :cover
  has_many :albums, dependent: :destroy
  has_many :tracks, through: :albums
  has_many :listenings, through: :tracks

  validates :name, presence: true, uniqueness: true
end
