require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  it "" do
    expect(FactoryBot.create(user)).to be_valid
  end

  let(:user) { Factory.build(:user) }

end