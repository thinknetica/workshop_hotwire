class User < ApplicationRecord
  has_secure_password

  has_many :listenings, dependent: :destroy, inverse_of: :user

  validates :username, presence: true, uniqueness: true
  validates :password, allow_nil: true, length: {minimum: 6}

  PREFIX = "@"
end
