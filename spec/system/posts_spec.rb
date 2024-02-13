require 'rails_helper'

RSpec.describe "posts", type: :system do
  let(:user) { create(:user) }
  let(:post) { create(:post) }
  let!(:post2) { create(:post, title: 'ログイン前テスト用')}
  describe 'Post CRUD' do
    describe 'ログイン前' do
      describe '新規投稿作成' do
        it '新規投稿のボタンが表示されない' do
          visit root_path
          expect(page).to have_no_content('投稿する')
        end
      end
      describe '投稿編集' do
        it '投稿編集のボタンが表示されない' do
          visit root_path
          click_on 'ログイン前テスト用'
          expect(page).to have_no_content('編集')
        end
      end
      describe '投稿削除' do
        it '投稿削除のボタンが表示されない' do
          visit root_path
          click_on 'ログイン前テスト用'
          expect(page).to have_no_content('編集')
        end
      end
    end
    describe 'ログイン後' do
      before { login(user) }
      describe '新規投稿作成' do
        context 'フォームの入力値が正常の場合' do
          it '投稿の新規作成が成功する' do
            visit root_path
            click_on '投稿する'
            expect(page).to have_content('新規投稿')
            fill_in 'post_title', with: 'テスト'
            fill_in 'post_address', with: '愛知県岡崎市'
            fill_in 'post_content', with: 'テストしてます'
            attach_file "post_post_image", "app/assets/images/test.png"
            click_button '送信'
            expect(page).to have_content('投稿一覧')
          end
        end
        context '画像が未選択の場合' do
          it '投稿の新規作成が成功する' do
            visit root_path
            click_on '投稿する'
            expect(page).to have_content('新規投稿')
            fill_in 'post_title', with: 'テスト'
            fill_in 'post_address', with: '愛知県岡崎市'
            fill_in 'post_content', with: 'テストしてます'
            click_button '送信'
            expect(page).to have_content('投稿一覧')
          end
        end
        context 'タイトルが未入力の場合' do
          it '投稿の新規作成が失敗する' do
            visit root_path
            click_on '投稿する'
            expect(page).to have_content('新規投稿')
            fill_in 'post_title', with: nil
            fill_in 'post_address', with: '愛知県岡崎市'
            fill_in 'post_content', with: 'テストしてます'
            click_button '送信'
            expect(page).to have_content('タイトルを入力してください')
          end
        end
        context '住所が未入力の場合' do
          it '投稿の新規作成が失敗する' do
            visit root_path
            click_on '投稿する'
            expect(page).to have_content('新規投稿')
            fill_in 'post_title', with: 'テスト'
            fill_in 'post_address', with: nil
            fill_in 'post_content', with: 'テストしてます'
            click_button '送信'
            expect(page).to have_content('住所を入力してください')
          end
        end
        context '本文が未入力の場合' do
          it '投稿の新規作成が失敗する' do
            visit root_path
            click_on '投稿する'
            expect(page).to have_content('新規投稿')
            fill_in 'post_title', with: 'テスト'
            fill_in 'post_address', with: '愛知県岡崎市'
            fill_in 'post_content', with: nil
            click_button '送信'
            expect(page).to have_content('本文を入力してください')
          end
        end
      end
      describe '投稿編集' do
        before do
          visit root_path
          click_on '投稿する'
          expect(page).to have_content('新規投稿')
          fill_in 'post_title', with: 'テスト'
          fill_in 'post_address', with: '愛知県岡崎市'
          fill_in 'post_content', with: 'テストだ'
          click_button '送信'
          click_on 'テスト'
          expect(page).to have_content('テストだ')
        end
        context 'フォームの入力値が正しい場合' do
          it '投稿の編集が成功する' do
            click_on '編集'
            fill_in 'post_title', with: 'テスト編集後'
            fill_in 'post_address', with: '愛知県岡崎市上和田町'
            fill_in 'post_content', with: '編集したよ'
            click_on '更新'
            expect(page).to have_content('テスト編集後')
          end
        end
        context 'タイトルが未入力の場合' do
          it '投稿の編集が失敗する' do
            click_on '編集'
            fill_in 'post_title', with: nil
            fill_in 'post_address', with: '愛知県岡崎市上和田町'
            fill_in 'post_content', with: '編集したよ'
            click_on '更新'
            expect(page).to have_content('タイトルを入力してください')
          end
        end
        context '住所が未入力の場合' do
          it '投稿の編集が失敗する' do
            click_on '編集'
            fill_in 'post_title', with: 'テスト編集後'
            fill_in 'post_address', with: nil
            fill_in 'post_content', with: '編集したよ'
            click_on '更新'
            expect(page).to have_content('住所を入力してください')
          end
        end
        context '本文が未入力の場合' do
          it '投稿の編集が成功する' do
            click_on '編集'
            fill_in 'post_title', with: 'テスト編集後'
            fill_in 'post_address', with: '愛知県岡崎市上和田町'
            fill_in 'post_content', with: nil
            click_on '更新'
            expect(page).to have_content('本文を入力してください')
          end
        end
      end
      describe '投稿削除' do
        it '投稿の削除が成功する' do
          visit root_path
          click_on '投稿する'
          expect(page).to have_content('新規投稿')
          fill_in 'post_title', with: 'テスト'
          fill_in 'post_address', with: '愛知県岡崎市'
          fill_in 'post_content', with: 'テストだ'
          click_button '送信'
          click_on 'テスト'
          expect(page).to have_content('テストだ')
          click_on '削除'
          page.driver.browser.switch_to.alert.accept
          expect(current_path).to eq posts_path
        end
      end
    end  
  end
end
