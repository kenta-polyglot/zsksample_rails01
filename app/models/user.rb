class User < ApplicationRecord
  before_save {self.email = self.email.downcase}
  validates(:name, presence: true, length: {maximum: 50}) 
  VALID_EMAIL_REGREX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates(:email, presence: true, length: {maximum: 255}, 
            format: {with: VALID_EMAIL_REGREX},
            uniqueness: true)
end
