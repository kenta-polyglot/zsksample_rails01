require 'rails_helper'

RSpec.feature '/microposts', type: :feature do
  # Micropostsが５個以下の時にページネーションが表示されない事
  context 'Micropostsが５個以下の場合' do
    # 1~5個の中からランダムでMicroposts生成
    background do
      create_list(:micropost, rand(1..5))
    end

    scenario 'ページネーションが表示されない事' do
      visit microposts_path
      expect(page).to have_no_xpath("/html/body/nav[@class='pagination']")
    end
  end

  # Micropostsが６個以上の時にページネーションが表示される事
  context 'Micropostsが６個以上の場合' do
    # 6~30個の中からランダムでMicroposts生成
    background do
      # create_list(:microposts, rand(6..30))
      @rand = rand(6..30)
      create_list(:micropost, @rand)
    end
    # １ページ目の場合
    context '１ページ目の場合' do
      scenario 'ページネーションが表示される事' do
        visit microposts_path
        expect(page).to have_xpath("/html/body/nav[@class='pagination']")
        # first(先頭へ)が表示されない事
        expect(page).to have_no_xpath("/html/body/nav/span[@class='first']")
        # previous(１つ前へ)が表示されない事
        expect(page).to have_no_xpath("/html/body/nav/span[@class='prev']")
        # last(最後尾へ)が表示される事
        expect(page).to have_xpath("/html/body/nav/span[@class='last']")
        # next(１つ後ろへ)が表示される事
        expect(page).to have_xpath("/html/body/nav/span[@class='next']")
      end
      scenario '次ページへ遷移できる事' do
        # 次ページのリンクをクリックした時ページが表示される事
        visit microposts_path
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
        visit "microposts?page=#{@last}"
        expect(page).to have_xpath("/html/body/nav[@class='pagination']")
        # first(先頭へ)が表示される事
        expect(page).to have_xpath("/html/body/nav/span[@class='first']")
        # previous(一個前へ)が表示される事
        expect(page).to have_xpath("/html/body/nav/span[@class='prev']")
        # last(最後尾へ)が表示されない事
        expect(page).to have_no_xpath("/html/body/nav/span[@class='last']")
        # next(一個後へ)が表示されない事
        expect(page).to have_no_xpath("/html/body/nav/span[@class='next']")
      end
      # 最終の一個前のページのリンクをクリックした時ページが表示される事
      scenario '前ページへ遷移できる事' do
        # 次ページのリンクをクリックした時ページが表示される事
        visit "microposts?page=#{@last}"
        click_on @last - 1
        expect(page.status_code).to eq(200)
      end
    end
  end
end

RSpec.feature '/micropost#new', type: :feature do
  describe '画像アップロード機能' do
    background do
      @micropost = FactoryBot.create(:micropost)
    end
    context '画像無しの場合' do
      scenario '投稿が保存/参照できる事' do
        visit new_micropost_path

        expect(-> {
          fill_in 'Content', with: @micropost.content
          fill_in 'User', with: @micropost.user_id
          click_on 'Create Micropost'
        }).to change(Micropost, :count).by(1)

        expect(current_path).to eq micropost_path(Micropost.last)
        expect(page).to have_content 'Micropost was successfully created.'
        expect(page).to have_selector 'p', text: @micropost.content
        expect(page).to have_selector 'p', text: @micropost.user_id
        expect(page).to have_no_selector 'img'
      end
    end

    context '画像ありの場合' do
      context '対応するサイズ/拡張子の場合' do
        background do
          @valid_image = "spec/fixtures/files/image#{rand(1..3)}.jpg"
        end
        scenario '投稿が保存/参照できる事' do
          visit new_micropost_path

          expect(-> {
            fill_in 'Content', with: @micropost.content
            fill_in 'User', with: @micropost.user_id
            attach_file 'Image', @valid_image
            click_on 'Create Micropost'
          }).to change(Micropost, :count).by(1)

          expect(current_path).to eq micropost_path(Micropost.last)
          expect(page).to have_content 'Micropost was successfully created.'
          expect(page).to have_selector 'p', text: @micropost.content
          expect(page).to have_selector 'p', text: @micropost.user_id
          expect(page).to have_selector 'img'
        end
      end

      context '非対応サイズの場合' do
        background do
          @invalid_image = "spec/fixtures/files/image_large#{rand(1..3)}.jpg"
        end
        scenario '投稿が保存されない事' do
          visit new_micropost_path

          fill_in 'Content', with: @micropost.content
          fill_in 'User', with: @micropost.user_id
          attach_file 'Image', @invalid_image
          click_on 'Create Micropost'

          expect(page).to have_content 'は5MB以内にしてください'
        end
      end

      context '非対応拡張子の場合' do
        background do
          files = %w[file1.zip file2.pdf file3.rtf]
          @invalid_file = "spec/fixtures/files/#{files[rand(0..2)]}"
        end
        scenario '投稿が保存されない事' do
          visit new_micropost_path

          fill_in 'Content', with: @micropost.content
          fill_in 'User', with: @micropost.user_id
          attach_file 'Image', @invalid_file
          click_on 'Create Micropost'

          expect(page).to have_content 'は画像形式でアップロードしてください'
        end
      end
    end
  end
end
