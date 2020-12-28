require 'rails_helper'
RSpec.describe '/users', type: :request do
  before do
    @user = FactoryBot.create(:user)
  end

  describe 'GET /index' do
    it 'indexアクションへリクエストすると正常にリクエストが返ってくる' do
      get users_path
      expect(response.status).to eq 200
    end
    it 'Nameが表示されている' do
      get users_path
      expect(response.body).to include @user.name
    end
    it 'emailが表示されている' do
      get users_path
      expect(response.body).to include @user.email
    end
  end
  describe 'GET /show' do
    it 'showアクションへリクエストすると正常にリクエストが返ってくる' do
      get user_path(@user)
      expect(response.status).to eq 200
    end
    it 'Nameが表示されている' do
      get user_path(@user)
      expect(response.body).to include @user.name
    end
    it 'emailが表示されている' do
      get user_path(@user)
      expect(response.body).to include @user.email
    end
  end
  describe 'GET /new' do
    it 'newアクションへリクエストすると正常にリクエストが返ってくる' do
      get new_user_path
      expect(response.status).to eq 200
    end
  end
  describe 'GET /edit' do
    it 'editアクションへリクエストすると正常にリクエストが返ってくる' do
      get edit_user_path(@user)
      expect(response.status).to eq 200
    end
    it 'Nameが表示されている' do
      get edit_user_path(@user)
      expect(response.body).to include @user.name
    end
    it 'emailが表示されている' do
      get edit_user_path(@user)
      expect(response.body).to include @user.email
    end
  end
  describe 'POST /create' do
    context 'パラメーターが妥当な場合' do
      it 'リクエストが成功すること' do
        post users_path, params: { user: FactoryBot.attributes_for(:user) }
        expect(response.status).to eq 302
      end
      it 'ユーザーが登録されること' do
        expect do
          post users_path, params: { user: FactoryBot.attributes_for(:user) }
        end.to change(User, :count).by(1)
      end
      it 'リダイレクトすること' do
        post users_path, params: { user: FactoryBot.attributes_for(:user) }
        expect(response).to redirect_to User.last
      end
    end
    context 'パラメータが不正な場合' do
      it 'リクエストが成功すること' do
        post users_path, params: { user: FactoryBot.attributes_for(:user, :invalid) }
        # Userモデルにvalidatesを加えたので、invalidの場合リダイレクトしなくなるので302→200に変更
        expect(response.status).to eq 200
      end
    end
  end
  describe 'PATCH /update' do
    context 'パラメーターが妥当な場合' do
      it 'リクエストが成功すること' do
        patch user_path(@user), params: { user: FactoryBot.attributes_for(:user) }
        expect(response.status).to eq 302
      end
      it 'リダイレクトすること' do
        put user_path(@user), params: { user: FactoryBot.attributes_for(:user) }
        expect(response).to redirect_to User.last
      end
    end
    context 'パラメータが不正な場合' do
      it 'リクエストが成功すること' do
        put user_path(@user), params: { user: FactoryBot.attributes_for(:user, :invalid) }
        # Userモデルにvalidatesを加えたので、invalidの場合リダイレクトしなくなるので302→200に変更
        expect(response.status).to eq 200
      end
    end
  end
  describe 'DELETE /destroy' do
    it 'リクエストが成功すること' do
      delete user_path(@user)
      expect(response.status).to eq 302
    end
    it 'ユーザーが削除されること' do
      expect do
        delete user_path(@user)
      end.to change(User, :count).by(-1)
    end
    it 'ユーザー一覧にリダイレクトすること' do
      delete user_path(@user)
      expect(response).to redirect_to users_path
    end
  end
end
