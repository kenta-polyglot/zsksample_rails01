require 'rails_helper'

RSpec.describe Micropost, type: :model do
  before do
    @micropost = FactoryBot.create(:micropost)
  end

  describe 'Micropostの投稿'
  context '投稿が上手くいくとき' do
    it '正しく情報を入力できれば投稿できる' do
      expect(@micropost).to be_valid
    end
  end

  context '投稿がうまくいかないとき' do
    it 'contentが空だと投稿できない' do
      @micropost.content = nil
      @micropost.valid?
      expect(@micropost.errors.full_messages).to include("Content can't be blank")
    end
    it 'contentが141文字以上だと投稿できない' do
      # 141字のダミーデータ
      @micropost.content = 'この文章はダミーです。文字の大きさ、量、字間、行間等を確認するために入れています。この文章はダミーです。文字の大きさ、量、字間、
      行間等を確認するために入れています。この文章はダミーです。文字の大きさ、量、字間、行間等を確認するために入れています。この文章はダミーです。文字の大きさは'
      @micropost.valid?
      expect(@micropost.errors.full_messages).to include('Content is too long (maximum is 140 characters)')
    end
    it 'userに紐付いていないと投稿できない' do
      @micropost.user = nil
      @micropost.valid?
      expect(@micropost.errors.full_messages).to include('User must exist')
    end
    # expect(@user).not_to be_valid
  end
end
