# frozen_string_literal: true
require 'rails_helper'
RSpec.describe Post, type: :model do
  describe "正常系の機能" do
    context "正しく入力さている場合" do
      let(:post) { build(:post) }
      it "保存できる" do
        expect(post.valid?).to eq true
      end
    end
  end
  describe "バリデーション" do
    context "titleカラム" do
      let(:post) {build(:post, title: nil)}
      it "タイトルが空の場合保存できない" do
        expect(post).not_to be_valid
      end
    end
    context "contentカラム" do
      let(:post) {build(:post, content: nil)}
      it "コンテントが空の場合保存できない" do
        expect(post).not_to be_valid
      end
    end
    context "addressカラム" do
      let(:post) {build(:post, address: nil)}
      it "住所が空の場合保存できない" do
        expect(post).not_to be_valid
      end
    end
  end
end
