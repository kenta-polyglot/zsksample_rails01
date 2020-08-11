require 'rails_helper'

RSpec.describe 'Microposts', type: :request do
  describe 'GET /index' do
    let(:sample) { FactoryBot.create :sample }
    it 'renders a successful response' do
      get microposts_url
      expect(response).to be_successful
    end
    it 'response.body include test' do
      # micropost = Micropost.new(user_id: 1, content: 'sample')
      get microposts_url
      expect(response.body).to include 'micropost'
    end
  end
  describe 'GET /show' do
    it 'renders a successful response' do
      micropost = Micropost.new(user_id: 1, content: 'sample')
      get microposts_url(micropost)
      expect(response).to be_successful
    end
    it 'render a response.body include test' do
      micropost = Micropost.new(user_id: 1, content: 'sample')
      get microposts_url(micropost)
      expect(response.body).to include 'micropost'
    end
  end
  describe 'GET /new' do
    let(:sample) { FactoryBot.create :sample }
    it 'renders a successful response' do
      # micropost = Micropost.new(user_id: 1, content: 'sample')
      get new_micropost_url
      expect(response).to be_successful
    end
  end
  describe 'GET /edit' do
    let(:sample) { FactoryBot.create :sample }
    it 'renders a successful response' do
      get edit_micropost_url(sample)
      expect(response).to be_successful
    end
    it 'render a response.body include test' do
      get edit_micropost_url(sample)
      expect(response.body).to include 'test'
    end
  end
  describe 'POST /create' do
    # ユーザが新規作成されること
    it 'creates a new Micropost' do
      expect do
        post microposts_url, params: { micropost: FactoryBot.attributes_for(:sample) }
      end.to change(Micropost, :count).by(1)
    end
    # リダイレクトすること
    it 'redirects to the created micropost' do
      post microposts_url, params: { micropost: FactoryBot.attributes_for(:sample) }
      expect(response).to redirect_to(micropost_url(Micropost.last))
    end
  end
  describe 'PATCH /update' do
    let(:sample) { FactoryBot.create :sample }
    # リクエストが成功すること
    it 'request to update micropost' do
      patch micropost_url(sample), params: { micropost: FactoryBot.attributes_for(:sample) }
      sample.reload
    end
    # ユーザ名が更新されること
    it 'update micropost' do
      expect do
        patch micropost_url(sample), params: { micropost: FactoryBot.attributes_for(:example) }
      end.to change { Micropost.find(sample.id).content }.from('test').to('sample')
    end
    # リダイレクトすること
    it 'redirects to the micropost' do
      patch micropost_url(sample), params: { micropost: FactoryBot.attributes_for(:example) }
      expect(response).to redirect_to Micropost.last
    end
  end
  describe 'DELETE #destroy' do
    let!(:sample) { FactoryBot.create :sample }
    it 'request to delete micropost' do
      expect do
        delete micropost_url sample
      end.to change(Micropost, :count).by(-1)
    end
    it 'redirect to the micropost' do
      delete micropost_url sample
      expect(response).to redirect_to(microposts_url)
    end
  end
end
