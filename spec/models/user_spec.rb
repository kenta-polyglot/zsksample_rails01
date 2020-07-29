require 'rails_helper'

RSpec.describe User, type: :model do

  it "正常ケースのテスト" do
    user = User.new(name: 'sample', email: 'sample@example.com')
    expect(user).to be_valid
  end

  it "異常ケース：nameが空文字" do
    user = User.new(name: nil, email: 'sample@example.com')
    expect(user).to be_invalid
  end

  it "異常ケース：emailが空文字" do
    user = User.new(name: 'sample', email: nil)
    expect(user).to be_invalid
  end

  it "異常ケース：nameが2文字未満" do
    user = User.new(name: 'a', email: 'sample@example.com')
    expect(user).to be_invalid
    expect(user.errors[:name]).to include("is too short (minimum is 2 characters)")
  end

  it "異常ケース：nameが13文字以上" do
    user = User.new(name: 'a' * 13, email: 'sample@example.com')
    user.valid?
    expect(user.errors[:name]).to include("is too long (maximum is 12 characters)")
  end

  it "異常ケース：emailが256文字以上" do
    user = User.new(name: 'sample', email: 'a' * 256)
    user.valid?
    expect(user.errors[:email]).to include("is too long (maximum is 255 characters)")
  end
end
