require 'rails_helper'

RSpec.describe '/microposts', type: :request do
  let(:user) { User.create!(name: 'foober', email: 'foober@test.com') }
  let(:valid_attributes) { { user_id: user.id, content: 'foober' } }
  let(:invalid_attributes) { { user_id: user.id, content: 'a' * 141 } }

  describe 'GET /index' do
    it 'indexアクションへリクエストすると正常にリクエストが返ってくる' do
      Micropost.create! valid_attributes
      get microposts_url
      expect(response).to have_http_status 200
    end
  end
  describe 'GET /show' do
    it 'showアクションへリクエストすると正常にリクエストが返ってくる' do
      micropost = Micropost.create! valid_attributes
      get micropost_url(micropost)
      expect(response).to have_http_status 200
    end
  end
  describe 'GET /new' do
    it 'newアクションへリクエストすると正常にリクエストが返ってくる' do
      get new_micropost_url
      expect(response).to have_http_status 200
    end
  end
  describe 'GET /edit' do
    it 'editアクションへリクエストすると正常にリクエストが返ってくる' do
      micropost = Micropost.create! valid_attributes
      get edit_micropost_url(micropost)
      expect(response).to have_http_status 200
    end
  end
  describe 'POST /create' do
    context 'パラメーターが妥当な場合' do
      it 'マイクロポストが作成されること' do
        expect do
          post microposts_url, params: { micropost: valid_attributes }
        end.to change(Micropost, :count).by(1)
      end
      it 'リダイレクトすること' do
        post microposts_url, params: { micropost: valid_attributes }
        expect(response).to redirect_to(micropost_url(Micropost.last))
      end
    end
    context 'パラメータが不正な場合' do
      it 'マイクロポストが作成されないこと' do
        expect do
          post microposts_url, params: { micropost: invalid_attributes }
        end.to change(Micropost, :count).by(0)
      end
      it 'リクエストが成功すること' do
        post microposts_url, params: { micropost: invalid_attributes }
        expect(response).to have_http_status 200
      end
    end
  end
  describe 'PATCH /update' do
    context 'パラメーターが妥当な場合' do
      let(:new_attributes) { { content: 'content' } }

      it 'マイクロポストが更新されること' do
        micropost = Micropost.create! valid_attributes
        expect do
          patch micropost_url(micropost), params: { micropost: new_attributes }
        end.to change { Micropost.find(micropost.id).content }.from(micropost.content).to(new_attributes[:content])
      end
      it 'リダイレクトすること' do
        micropost = Micropost.create! valid_attributes
        patch micropost_url(micropost), params: { micropost: new_attributes }
        micropost.reload
        expect(response).to redirect_to(micropost_url(micropost))
      end
    end
    context 'パラメータが不正な場合' do
      it 'リクエストが成功すること' do
        micropost = Micropost.create! valid_attributes
        patch micropost_url(micropost), params: { micropost: invalid_attributes }
        expect(response).to have_http_status 200
      end
    end
  end
  describe 'DELETE /destroy' do
    it 'マイクロポストが破棄されていること' do
      micropost = Micropost.create! valid_attributes
      expect do
        delete micropost_url(micropost)
      end.to change(Micropost, :count).by(-1)
    end
    it 'マイクロポスト一覧にリダイレクトすること' do
      micropost = Micropost.create! valid_attributes
      delete micropost_url(micropost)
      expect(response).to redirect_to(microposts_url)
    end
  end
end
