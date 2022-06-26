# アプリケーション名
yumegurism

# アプリケーション概要
九州内の温泉情報をシェアし、ユーザー同士でコミュニケーションもとることで、温泉好きのコミュニティを作ることができる。

# URL
https://onsen-app-38009.herokuapp.com/posts

# テスト用アカウント
・basic認証パスワード：admin
・basic認証ID：3993
・ニックネーム：test
・メールアドレス：Yuki@gmail.com
・パスワード：Yuki1231


# 利用方法
## 温泉情報投稿
1.トップページのヘッダーからユーザー新規登録を行う

2.新規投稿ボタンから、写真・場所名・テキスト・泉質を入力し投稿する。
## ユーザー同士のアクション
1.一覧ページから画像をクリックすると詳細画面に入る。

2.詳細画面に入るといいねを押せたり、コメントを入力することができる。

# アプリケーションを作成した背景
私自身、日帰り温泉に行ったり、旅館にたまに泊まりにいくことがあります。
その際に評価であったり、雰囲気で行く場所を決めています。ネットで探してみると
情報量が多く、決めかねることが多々あります。
知りたい情報をすぐに得ることができるコンパクトなアプリケーションがあったら便利と考えこのアプリを制作することにしました。

# 洗い出した要件
https://docs.google.com/spreadsheets/d/1KTwhx_go50To3R03khBooQKtLbZgtMFeOiozgHObdqA/edit#gid=982722306

# 実装した機能についての画像やGIFおよびその説明
<!-- ## トップページ
ヘッダーにログイン・新規登録ボタン左上にアプリ名を表示。
[![Image from Gyazo](https://i.gyazo.com/04b767420a8720be6ee5316e27069177.jpg)](https://gyazo.com/04b767420a8720be6ee5316e27069177) -->

## ユーザー登録
必要な情報を入力する。
[![Image from Gyazo](https://i.gyazo.com/0f553c98ea9b518f2b949bbb31a33aaf.gif)](https://gyazo.com/0f553c98ea9b518f2b949bbb31a33aaf)

## 一覧ページ
ユーザーが投稿した写真が一覧で確認でき、写真をクリックすると詳細ページに遷移。
[![Image from Gyazo](https://i.gyazo.com/0278674af83f5c1e4070ea23b8bc7d7d.gif)](https://gyazo.com/0278674af83f5c1e4070ea23b8bc7d7d)

## 詳細ページ
ユーザーが投稿した内容が確認できるこのページで編集・削除・コメント・いいねが可能。
[![Image from Gyazo](https://i.gyazo.com/b0c66b322cab10a7109c6e0a26f97786.gif)](https://gyazo.com/b0c66b322cab10a7109c6e0a26f97786)

## 編集・削除機能
投稿した本人であれば編集削除が可能。
[![Image from Gyazo](https://i.gyazo.com/2077013c76685e0fd369ac5f422467be.gif)](https://gyazo.com/2077013c76685e0fd369ac5f422467be)

## コメント機能
ログインユーザーであればコメント可能。
[![Image from Gyazo](https://i.gyazo.com/ce1c37162f4ce06e53676e50f64e265e.gif)](https://gyazo.com/ce1c37162f4ce06e53676e50f64e265e)


# 実装予定の機能
現在、非同期のいいね機能を実装中
今後はトップページでアプリの機能紹介
検索機能、通知機能、ユーザー情報編集機能実装予定

# データベース設計
[![Image from Gyazo](https://i.gyazo.com/f1a0b3022038189de079d7e0cf469368.png)](https://gyazo.com/f1a0b3022038189de079d7e0cf469368)

# 画面遷移図
[![Image from Gyazo](https://i.gyazo.com/42e82288ceace7cf631582c5d19eede8.png)](https://gyazo.com/42e82288ceace7cf631582c5d19eede8)

# テーブル設計
## usersテーブル
| Column             | Type   | Options                 |
| ------------------ | ------ | -----------             |
| name               | string | null: false             |
| email              | string | unique: true,null: false|
| password           | string | null: false             |
| image              | string | null: false             |


### Association
- has_many :comments
- has_many :posts
- has_many :likes


## postsテーブル
| Column             | Type   | Options                 |
| ------------------ | ------ | -----------             |
| image              | string | null: false             |
| address            | string | null: false             |
| latitude           | decimal| precision: 9, scale: 6  |
| longitude          | decimal| precision: 10, scale: 6 |
| description        | text   | null: false             |

### Association
- belongs_to :user
- has_many :comments
- has_many :likes



## commentsテーブル
| Column             | Type      | Options                       |
| ------------------ | ----------| ------------------------------|
| content            | text      | null: false                   |
| user               | references| null: false,foreign_key: true | 
| post               | references| null: false,foreign_key: true |

### Association
- belongs_to :user
- belongs_to :post


## Likesテーブル
| Column             | Type      | Options                       |
| ------------------ | --------- | ----------------------------- |
| user               | references| null: false,foreign_key: true | 
| post               | references| null: false,foreign_key: true |

### Association
- belongs_to :user
- belongs_to :post


# 開発環境
Ruby,Ruby on Rails,jquery,HTML,CSS,ajax

# ローカルでの動作方法
% git clone https://github.com/yudaiishiyama/onsen-app.git

% cd onsen_app

% bundle install

% rails db:create

% rails db:migrate

% yarn install

# 工夫したポイント
1.ユーザーが得たい情報を得れるか
・詳細ページからGoogleマップ、泉質、温泉の紹介文を記入するように実装しました。
・一覧ページからは画像がすぐに見えるように配置しました。

2.ユーザーが楽しんでもらうため
・温泉のシズル感を出したデザイン（背景を温泉の湯気、色をイメージ）して実装しました。
・コメントを入力、削除、いいね機能の回数の表示をして他のユーザーからの評価が見えるように実装しました。

3.ユーザー目線を考えた実装
・レスポンシブデザインを実装し、スマホでも使いやすいように実装しました。
・