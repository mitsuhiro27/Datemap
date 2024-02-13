require 'rails_helper'
RSpec.describe "favorites", type: :system do
  describe 'post一覧画面のテスト' do
    let(:user) { create(:user) }
    let!(:post) { create(:post, user: user) }

    context 'いいね確認' do
      it 'リンクが諸々正しい' do
        visit root_path
        click_button 'ゲストログイン'
        find(".navbar-toggler-icon").click
        click_on '投稿一覧'
        expect(page).to have_css('i.bi-heart') 
      end
    end
  end
end
