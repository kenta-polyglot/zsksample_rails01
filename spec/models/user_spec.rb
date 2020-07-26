require 'rails_helper'

RSpec.describe User, type: :model do

  # name(test), email(test@example.com)
  it "is valid with name and email" do
    user = FactoryBot.create(:user)
    user = User.new(name: 'sample', email: 'sample@example.com')
    expect(user).to be_valid
  end
end
