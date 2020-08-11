class User < ApplicationRecord
  has_many :microposts, dependent: :destroy
  validates :name,
            presence: true,
            length: { minimum: 2, maximum: 12 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
  validates :email,
            presence: true,
            length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
end
