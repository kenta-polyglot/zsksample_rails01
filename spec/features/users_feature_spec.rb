require 'rails_helper'

RSpec.feature '/users', type: :feature do
  # ユーザーが５人以下の時にページネーションが表示されない事
  context 'ユーザーが５人以下の場合' do
    # 1~5人の中からランダムでユーザー生成
    background do
      create_list(:user, rand(1..5))
    end

    scenario 'ページネーションが表示されない事' do
      visit users_path
      expect(page).to have_no_xpath("/html/body/nav[@class='pagination']")
    end
  end

  # ユーザーが６人以上の時にページネーションが表示される事
  context 'ユーザーが６人以上の場合' do
    # 6~30人の中からランダムでユーザー生成
    background do
      # create_list(:user, rand(6..30))
      @rand = rand(6..30)
      create_list(:user, @rand)
    end
    # １ページ目の場合
    context '１ページ目の場合' do
      scenario 'ページネーションが表示される事' do
        visit users_path
        expect(page).to have_xpath("/html/body/nav[@class='pagination']")
        # first(先頭へ)が表示されない事
        expect(page).to have_no_xpath("/html/body/nav/span[@class='first']")
        # previous(一つ前へ)が表示されない事
        expect(page).to have_no_xpath("/html/body/nav/span[@class='prev']")
        # last(最後尾へ)が表示される事
        expect(page).to have_xpath("/html/body/nav/span[@class='last']")
        # next(一つ後へ)が表示される事
        expect(page).to have_xpath("/html/body/nav/span[@class='next']")
      end
      scenario '次ページへ遷移できる事' do
        # 次ページのリンクをクリックした時ページが表示される事
        visit users_path
        click_on '2'
        expect(page.status_code).to eq(200)
      end
    end

    # 最終ページの場合
    context '最終ページの場合' do
      background do
        @last = (@rand / 5.0).ceil
      end
      scenario 'ページネーションが表示される事' do
        visit "users?page=#{@last}"
        expect(page).to have_xpath("/html/body/nav[@class='pagination']")
        # first(先頭へ)が表示される事
        expect(page).to have_xpath("/html/body/nav/span[@class='first']")
        # previous(一つ前へ)が表示される事
        expect(page).to have_xpath("/html/body/nav/span[@class='prev']")
        # last(最後尾へ)が表示されない事
        expect(page).to have_no_xpath("/html/body/nav/span[@class='last']")
        # next(一つ後へ)が表示されない事
        expect(page).to have_no_xpath("/html/body/nav/span[@class='next']")
      end
      # 最終の一つ前のページのリンクをクリックした時ページが表示される事
      scenario '前ページへ遷移できる事' do
        # 次ページのリンクをクリックした時ページが表示される事
        visit "users?page=#{@last}"
        click_on @last - 1
        expect(page.status_code).to eq(200)
      end
    end
  end
end
