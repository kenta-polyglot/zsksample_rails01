class Micropost < ApplicationRecord
  belongs_to :user, optional: true
  validates :content,
            presence: true,
            length: { maximum: 140 }
end
