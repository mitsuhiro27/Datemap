require 'rails_helper'

RSpec.describe "posts", type: :system do
  let(:user) { create(:user) }
  let(:post) { create(:post) }
  describe 'Post CRUD' do
    describe 'ログイン前' do
      describe '新規投稿作成' do
        it '新規投稿のボタンが表示されない' do
          visit root_path
          expect(page).to have_no_content('投稿する')
        end
      end
    end
    describe 'ログイン後' do
      describe '新規投稿作成' do
        before { login(user) }
        context 'フォームの入力値が正常の場合' do
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
    end  
  end
end
