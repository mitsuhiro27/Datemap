# frozen_string_literal: true
require 'rails_helper'
RSpec.describe User, type: :model do
  describe "正常系の機能" do
    context "正しく入力さている場合" do
      let(:user) { build(:user) }
      it "保存できる" do
        expect(user.valid?).to eq true
      end
    end
  end
  describe "バリデーション" do
    subject { user.valid? }
    context "emailカラム" do
      let(:user) { build(:user, email: "") }
      it "emailが空の場合保存できない" do
        expect(subject).to eq false
      end
      before { create(:user, email: "test@example.com") }
      let(:user) { build(:user, email: "test@example.com") }
      it "emailが既に存在する場合保存できない" do
        expect(subject).to eq false
      end
      it "emailに@が含まれていない場合保存できない" do
        user.email = ('invalidemail')
        expect(user).not_to be_valid
      end
    end
    context "nameカラム" do
      let(:user) { build(:user, name: "") }
      it "nameが空の場合保存できない" do
        expect(subject).to eq false
      end
    end
    context "passwordカラム" do
      it "passwordが空の場合保存できない" do
        user = build(:user, password: nil)
        expect(user.valid?).to eq false
      end
      it "passwordが5文字以下の場合保存できない" do
      password = Faker::Internet.password(min_length: 5, max_length: 5)
      user = build(:user, password: password, password_confirmation: password)
      expect(user.valid?).to eq false
      end
    end
  end
end
