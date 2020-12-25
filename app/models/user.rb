class User < ApplicationRecord
  with_options presence: true do
    validates :name1
    validates :email
  end
end
