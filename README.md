## users テーブル
  
| Column              | Type    | Options                   |
|---------------------|---------|---------------------------|
| email               | string  | null: false, unique: true |
| encrypted_password  | string  | null: false               |
| nickname            | string  | null: false               |
| last_name           | string  | null: false               |
| first_name          | string  | null: false               |
| last_name_kana      | string  | null: false               |
| first_name_kana     | string  | null: false               |
| date_of_birth       |  date   | null: false               |

  
### Association
- has_many :goods
- has_many :purchases
  
  
## goods テーブル
  
| Column                 | Type       | Options                               |
|------------------------|------------|---------------------------------------|
| user                   | references | null: false, foreign_key: true        |
| name                   | string     | null: false                           |
| description            | text       | null: false                           |
| category_id            | integer    | null: false                           |
| condition_id           | integer    | null: false                           |
| shipping_fee_id        | integer    | null: false                           |
| region_of_origin_id    | integer    | null: false                           |
| days_to_ship_id        | integer    | null: false                           |
| price                  | integer    | null: false                           |
  
### Association
- belongs_to :user
- has_one :purchase
  
  
## purchases テーブル
  
| Column           | Type       | Options                               |
|------------------|------------|---------------------------------------|
| user             | references | null: false,                          |
| good             | references | null: false, foreign_key: true        |
  
### Association
- belongs_to :user
- belongs_to :good
- has_one :shipping_address 
  
  
## shipping_addressesテーブル
  
| Column           | Type       | Options                               |
|------------------|------------|---------------------------------------|
| purchase         | references | null: false, foreign_key: true        |
| user             | references | null: false, foreign_key: true        |
| postal_code      | string     | null: false                           |
| prefecture_id    | integer    | null: false                           |
| city             | string     | null: false                           |
| street_address   | string     | null: false                           |
| building_name    | string     |                                       |
| phone_number     | string     | null: false                           |
  
### Association
- belongs_to :purchase