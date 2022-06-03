# テーブル設計

## usersテーブル
| Column             | Type   | Options                 |
| ------------------ | ------ | -----------             |
| name               | string | null: false             |
| email              | string | unique: true,null: false|
| encrypted_password | string | null: false             |


### Association
- has_many :comments
- has_many :posts


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
| comments           | text      | null: false                   |
| user               | references| null: false,foreign_key: true | 
| post               | string    | null: false,foreign_key: true |

### Association
- belongs_to :user
- belongs_to :post


## Likesテーブル
| Column             | Type      | Options                       |
| ------------------ | --------- | ----------------------------- |
| user               | references| null: false,foreign_key: true | 
| post               | string    | null: false,foreign_key: true |

### Association
- belongs_to :user
- belongs_to :post


