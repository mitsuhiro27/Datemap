require 'rails_helper'

RSpec.describe "users", type: :system do
  let(:user) { create(:user) }
  describe 'User CRUD' do
    describe 'ログイン前' do
      describe 'ユーザー新規登録' do
        context 'フォームの入力値が正常の場合' do
          it 'ユーザーの新規作成が成功する' do
            visit  new_user_session_path
            expect(page).to have_content('新規登録')
            visit new_user_registration_path
            fill_in 'user_name', with: 'テスト'
            fill_in 'user_email', with: 'test@123.com'
            fill_in 'user_password', with: 'password'
            fill_in 'user_password_confirmation', with: 'password'
            click_button '登録する'
            expect(current_path).to eq user_path(1)
          end
        end
        context '名前未入力の場合' do
          it 'ユーザーの新規作成失敗' do
            visit new_user_registration_path
            fill_in 'user_name', with: nil
            fill_in 'user_email', with: 'test@123.com'
            fill_in 'user_password', with: 'password'
            fill_in 'user_password_confirmation', with: 'password'
            click_button '登録する'
            expect(page).to have_content "名前を入力してください"
          end
        end
        context 'メールアドレス未入力の場合' do
          it 'ユーザーの新規作成失敗' do
            visit new_user_registration_path
            fill_in 'user_name', with: 'test'
            fill_in 'user_email', with: nil
            fill_in 'user_password', with: 'password'
            fill_in 'user_password_confirmation', with: 'password'
            click_button '登録する'
            expect(page).to have_content "メールアドレスが入力されていません"
          end
        end
        context '登録済のメールアドレスの場合' do
          it 'ユーザーの新規作成失敗' do
            visit new_user_registration_path
            fill_in 'user_name', with: 'test'
            fill_in 'user_email', with: user.email
            fill_in 'user_password', with: 'password'
            fill_in 'user_password_confirmation', with: 'password'
            click_button '登録する'
            expect(page).to have_content "メールアドレスは既に使用されています"
          end
        end
        context 'パスワード未入力の場合' do
          it 'ユーザーの新規作成失敗' do
            visit new_user_registration_path
            fill_in 'user_name', with: 'test'
            fill_in 'user_email', with: 'test@123.com'
            fill_in 'user_password', with: nil
            fill_in 'user_password_confirmation', with: 'password'
            click_button '登録する'
            expect(page).to have_content "パスワードが入力されていません"
          end
        end
        context 'パスワードと確認用パスワードが不一致の場合' do
          it 'ユーザーの新規作成失敗' do
            visit new_user_registration_path
            fill_in 'user_name', with: 'test'
            fill_in 'user_email', with: 'test@123.com'
            fill_in 'user_password', with: 'aaaaaa'
            fill_in 'user_password_confirmation', with: 'bbbbbb'
            click_button '登録する'
            expect(page).to have_content "確認用パスワードとパスワードの入力が一致しません"
          end
        end
        context 'パスワードが6文字以下の場合' do
          it 'ユーザーの新規作成失敗' do
            visit new_user_registration_path
            fill_in 'user_name', with: 'test'
            fill_in 'user_email', with: 'test@123.com'
            fill_in 'user_password', with: 'pass'
            fill_in 'user_password_confirmation', with: 'pass'
            click_button '登録する'
            expect(page).to have_content "パスワードは6文字以上に設定して下さい"
          end
        end
      end
      describe 'ログイン' do
        context '正しいユーザー情報を入力した場合' do
          it 'ログインに成功する' do
            visit new_user_session_path
            fill_in 'user_email', with: user.email
            fill_in 'user_password', with: 'password'
            click_button 'ログイン'
            expect(current_path).to eq user_path(user)
          end
        end
        context '誤ったメールアドレスを入力した場合' do
          it 'ログインに失敗する' do
            visit new_user_session_path
            fill_in 'user_email', with: nil
            fill_in 'user_password', with: 'password'
            click_button 'ログイン'
            expect(page).to have_content 'メールアドレスまたはパスワードが違います。'
          end
        end
        context '誤ったパスワードを入力した場合' do
          it 'ログインに失敗する' do
            visit new_user_session_path
            fill_in 'user_email', with: user.email
            fill_in 'user_password', with: 'passsssss'
            click_button 'ログイン'
            expect(page).to have_content 'メールアドレスまたはパスワードが違います。'
          end
        end
        context 'ゲストログインボタンを押した場合' do
          it 'ゲストログインに成功する' do
            visit root_path
            click_button 'ゲストログイン'
            expect(page).to have_content 'guest@example.com'
          end
        end
      end
    end
    describe 'ログイン後' do
      before { login(user) }
        describe 'ユーザー編集' do
          context 'フォームの入力値が正常の場合' do
            it 'ユーザーの編集が成功する' do
              visit edit_user_registration_path(user)
              fill_in 'user_name', with: 'test'
              fill_in 'user_email', with: 'test@example.com'
              fill_in 'user_password', with: 'testpass'
              fill_in 'user_password_confirmation', with: 'testpass'
              click_button '更新'
              expect(current_path).to eq user_path(user)
              expect(page).to have_content 'アカウント情報を変更しました。'
            end
          end
          context '名前が未入力の場合' do
            it 'ユーザーの編集が失敗する' do
              visit edit_user_registration_path(user)
              fill_in 'user_name', with: nil
              fill_in 'user_email', with: 'test@example.com'
              fill_in 'user_password', with: 'testpass'
              fill_in 'user_password_confirmation', with: 'testpass'
              click_button '更新'
              expect(page).to have_content '名前を入力してください'
            end
          end
          context 'メールアドレスが未入力の場合' do
            it 'ユーザーの編集が失敗する' do
              visit edit_user_registration_path(user)
              fill_in 'user_name', with: 'test'
              fill_in 'user_email', with: nil
              fill_in 'user_password', with: 'testpass'
              fill_in 'user_password_confirmation', with: 'testpass'
              click_button '更新'
              expect(page).to have_content 'メールアドレスが入力されていません。'
            end
          end
          context 'アカウントの削除' do
            it 'アカウントの削除が出来る' do
              visit edit_user_registration_path(user)
              click_button 'アカウントを削除'
              page.driver.browser.switch_to.alert.accept
              expect(current_path).to eq root_path
            end
          end
          context '戻るをクリックした場合' do
            it 'マイページに戻る' do
            visit edit_user_registration_path(user)
              click_link '戻る'
              expect(current_path).to eq user_path(user)
            end
          end
        end
        describe 'ログアウト' do
          context 'ログアウトボタンを押した場合' do
            it 'ログアウト出来る' do
              visit root_path
              find(".navbar-toggler-icon").click
              click_on 'ログアウト'
              page.driver.browser.switch_to.alert.accept
              expect(page).to have_content 'ログアウトしました。'
            end
          end
        end
    end
  end
end
