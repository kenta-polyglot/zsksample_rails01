require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.create(:user)
  end

  describe '有効性の検証' do
    it 'Userオブジェクトが有効であること' do
      expect(@user).to be_valid
    end
  end

  describe '存在性の検証' do
    it '名前が存在すること' do
      @user.name = ' '
      expect(@user).not_to be_valid
    end
    it 'メールアドレスが存在すること' do
      @user.email = ' '
      expect(@user).not_to be_valid
    end
  end

  describe '入力値の長さの検証' do
    it '名前が50文字以内であること' do
      @user.name = 'a' * 51
      expect(@user).not_to be_valid
    end
    it 'メールアドレスが255文字以内であること' do
      @user.email = 'a' * 244 + '@example.com'
      expect(@user).not_to be_valid
    end
  end

  describe 'emailフォーマットの検証' do
    it 'メールアドレスのフォーマットが有効であること' do
      valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
      valid_addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
    it 'メールアドレスのフォーマットが無効であること' do
      invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
      invalid_addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end

  describe 'email一意性の検証' do
    it '重複したメールアドレスが無効であること' do
      FactoryBot.create(:user, email: 'zskteam1211@example.com')
      user = FactoryBot.build(:user, email: 'ZSKTeam1211@example.com')
      user.valid?
      expect(user.errors[:email]).to include('はすでに存在します')
    end
  end
end
