require 'rails_helper'

RSpec.describe Micropost, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  fixtures :users
  fixtures :microposts

  before do
    @user = users(:Hoge)
    @micropost = @user.microposts.build(content: 'Foobar')
  end

  it 'should be vaild' do
    expect(@micropost).to be_valid
  end

  it 'user id should be present' do
    @micropost.user_id = nil
    expect(@micropost).not_to be_valid
  end

  it 'content should be present' do
    @micropost.content = nil
    expect(@micropost).not_to be_valid
  end

  it 'content should be at most 140 characters' do
    @micropost.content = 'a' * 141
    expect(@micropost).not_to be_valid
  end

  it 'order should be most recent first' do
    @micropost.content = 'a' * 141
    expect(microposts(:most_recent)).to eq Micropost.first
  end
end
