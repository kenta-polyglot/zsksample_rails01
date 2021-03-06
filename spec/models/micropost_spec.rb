require 'rails_helper'

RSpec.describe Micropost, type: :model do
  before do
    @micropost = FactoryBot.build(:micropost)
  end

  describe '投稿の保存' do
    context '投稿できる場合' do
      it 'テキストとユーザー番号があれば投稿できる' do
        expect(@micropost).to be_valid
      end
    end
    context '投稿できない場合' do
      it 'テキストが空では投稿できない' do
        @micropost.content = ''
        @micropost.valid?
        expect(@micropost.errors.full_messages).to include("Content can't be blank")
      end
      it 'テキストが140文字以上では投稿できない' do
        @micropost.content = 'aaaaaaaaaa aaaaaaaaaa aaaaaaaaaa aaaaaaaaaa aaaaaaaaaa aaaaaaaaaa aaaaaaaaaa aaaaaaaaaa aaaaaaaaaa aaaaaaaaaa aaaaaaaaaa aaaaaaaaaa aaaaaaaaaa aaaaaaaaaa '
        @micropost.valid?
        expect(@micropost.errors.full_messages).to include('Content is too long (maximum is 140 characters)')
      end
    end
    it 'ユーザーが紐付いていなければ投稿できない' do
      @micropost.user = nil
      @micropost.valid?
      expect(@micropost.errors.full_messages).to include('User must exist')
    end
  end
end
