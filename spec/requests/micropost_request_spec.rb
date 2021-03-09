require 'rails_helper'

RSpec.describe 'Microposts', type: :request do
  describe 'マイクロポストを作成する' do
    let(:micropost) { FactoryBot.attributes_for(:micropost) }
    let(:post_request) { post microposts_path, params: { micropost: micropost } }
  end

  describe 'マイクロポストを削除する' do
    let!(:micropost) { FactoryBot.create(:micropost) }
    let(:delete_request) { delete micropost_path(micropost) }
  end
end
