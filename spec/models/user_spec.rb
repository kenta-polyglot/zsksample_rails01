require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation' do
    before do
      @user = FactoryBot.build(:user)
    end

    subject { @user }

    context '存在性の検証' do
      it 'is valid with a name and an email' do
        is_expected.to be_valid
      end

      it 'is invalid without a name' do
        @user.name = nil
        @user.valid?
        expect(@user.errors[:name]).to include("can't be blank")
      end

      it 'is invalid without an email ' do
        @user.email = nil
        @user.valid?
        expect(@user.errors[:email]).to include("can't be blank")
      end
    end

    context '長さの検証' do
      it 'is valid with name of 50 characters or less' do
        @user.name = 'a' * 50
        is_expected.to be_valid
      end

      it 'is invalid with too long name' do
        @user.name = 'a' * 51
        is_expected.to be_invalid
      end

      it 'is valid with email of 255 characters or less' do
        @user.email = "#{'a' * 243}@example.com"
        # "@example.com"　は 12文字
        # 243 + 12 = 255　を用いて email最大文字数のテストを行う
        is_expected.to be_valid
      end

      it 'is invalid with too long email' do
        @user.email = "#{'a' * 244}@example.com"
        is_expected.to be_invalid
      end
    end

    context 'フォーマットの検証' do
      it 'is valid when email format is valid' do
        addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
        addresses.each do |valid_address|
          @user.email = valid_address
          is_expected.to be_valid
        end
      end

      it 'is invalid when email format is invalid' do
        addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                       foo@bar_baz.com foo@bar+baz.com]
        addresses.each do |invalid_address|
          @user.email = invalid_address
          is_expected.to be_invalid
        end
      end
    end

    context '一意性の検証' do
      it 'is invalid with a duplicate email address' do
        @user.save
        other_user = User.new(name: 'FooBar',
                              email: @user.email)
        other_user.valid?
        expect(other_user.errors[:email]).to include('has already been taken')
      end
    end
  end
end
