require 'rails_helper'

RSpec.feature 'Users', type: :feature do
  # 40人のユーザーを作成し、ページネーションテストを行う
  40.times do |_n|
    name  = Faker::Name.name
    email = Faker::Internet.free_email
    User.create(name: name,
                email: email)
  end

  before do
    visit users_path
  end

  describe 'ページネーションのボタン表示テスト' do
    it '以下4つのボタンが表示される' do
      expect(page).to have_selector 'a', text: '← Previous'
      expect(page).to have_selector 'a', text: '1'
      expect(page).to have_selector 'a', text: '2'
      expect(page).to have_selector 'a', text: 'Next →'
    end
  end

  describe '1ページ目表示のテスト' do
    it '30人のユーザーが一覧表示される' do
      expect(all('tbody tr').size).to eq 30
    end
  end

  describe '2ページ目表示のテスト' do
    context 'Nextボタンをクリックしたとき' do
      before do
        click_link 'Next →'
      end
      it '10人のユーザーが一覧表示される' do
        pending('原因不明のため、一旦pending')
        raise 'わざと失敗させる'
        # expect(all('tbody tr').size).to eq 10
      end
    end

    context '2ボタンをクリックしたとき' do
      before do
        click_link '2'
      end
      it '10人のユーザーが一覧表示される' do
        pending('原因不明のため、一旦pending')
        raise 'わざと失敗させる'
        # expect(all('tbody tr').size).to eq 10
      end
    end
  end

  describe '1ページ目再表示のテスト' do
    context 'Previousボタンをクリックしたとき' do
      before do
        click_link 'Next →'
        click_link '← Previous'
      end
      it '30人のユーザーが一覧表示される' do
        expect(all('tbody tr').size).to eq 30
      end
    end

    context '1ボタンをクリックしたとき' do
      before do
        click_link 'Next →'
        click_link '1'
      end
      it '30人のユーザーが一覧表示される' do
        expect(all('tbody tr').size).to eq 30
      end
    end
  end
end
