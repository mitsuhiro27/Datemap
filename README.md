# Datemap

デートスポットを投稿できるサイトです。
自分のお気に入りのデートスポットを位置情報と共に、投稿する事ができます。他の人のおすすめのスポットを閲覧する事もできます。
レスポンシブ対応しているので、スマホからもご確認いただけます。


<img width="1435" alt="スクリーンショット 2024-02-20 13 36 12" src="https://github.com/mitsuhiro27/Datemap/assets/98004666/1ea328ee-df81-4a20-baad-0829b29d7348">
<img width="321" alt="スクリーンショット 2024-02-29 14 12 22" src="https://github.com/mitsuhiro27/Datemap/assets/98004666/ac967599-826c-4c92-92f2-f56c10dcf66a">
<img width="317" alt="スクリーンショット 2024-02-29 14 03 33" src="https://github.com/mitsuhiro27/Datemap/assets/98004666/7cc77eed-098c-4005-b262-030fe1d20009">

# URL
https://datemap-266611f05e8b.herokuapp.com/

画面中央のゲストログインボタンから、すぐにログイン頂けます。

# 使用技術

* Ruby 3.1.1
* Ruby on Rails  6.1.4
* sqlite　3.43.2
* RSpec
* Google Maps API

# 機能一覧
* ユーザー登録、ログイン機能(devise)
* 投稿機能
  - 画像投稿(carrierwave)
  - 位置情報検索機能(geocoder)
* いいね機能  ランキング機能
* 投稿検索機能

# テスト
*Rspec
単体テスト(model)
統合テスト(system)
