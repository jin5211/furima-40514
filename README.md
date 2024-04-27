# DB 設計

## users table

| Column             | Type                | Options                     |
|--------------------|---------------------|-----------------------------|
| nickname           | string              | null: false                 |
| email              | string              | null: false, unique: true   |
| encrypted_password | string              | null: false                 |
| last_name          | string              | null: false                 |
| first_name         | string              | null: false                 |
| last_name_kana     | string              | null: false                 |
| first_name_kana    | string              | null: false                 |
| birth_date         | date                | null: false                 |

### Association

* has_many :items
* has_many :orders

## items table

| Column                         | Type       | Options                         |
|--------------------------------|------------|---------------------------------|
| name                           | string     | null: false                     |
| info                           | text       | null: false                     |
| category_id                    | integer    | null: false                     |
| sales_status_id                | integer    | null: false                     |
| shipping_fee_status_id         | integer    | null: false                     |
| prefecture_id                  | integer    | null: false                     |
| scheduled_delivery_id          | integer    | null: false                     |
| price                          | integer    | null: false                     |
| user                           | references | null: false, foreign_key: true  |

### Association

- belongs_to :user
- has_one :order
- belongs_to_active_hash :category
- belongs_to_active_hash :sales_status
- belongs_to_active_hash :shipping_fee_status
- belongs_to_active_hash :prefecture
- belongs_to_active_hash :schedule_delivery

## orders table

| Column      | Type       | Options                        |
|-------------|------------|--------------------------------|
| item        | references | null: false, foreign_key: true |
| user        | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :shipping_info

## shipping_infos table

| Column        | Type       | Options                        |
|---------------|------------|--------------------------------|
| order         | references | null: false, foreign_key: true |
| postal_code   | string     | null: false                    |
| prefecture_id | integer    | null: false                    |
| city          | string     | null: false                    |
| address       | string     | null: false                    |
| building      | string     |                                |
| phone_number  | string     | null: false                    |

### Association

- belongs_to :order
- belongs_to_active_hash :prefecture

## ActiveHash: prefecture

| id  | name    |
|-----|---------|
| 1   | ---     |
| 2   | 北海道   |
| 3   | 青森県   |
| 4   | 岩手県   |
| 5   | 宮城県   |
| 6   | 秋田県   |
| 7   | 山形県   |
| 8   | 福島県   |
| 9   | 茨城県   |
| 10  | 栃木県   |
| 11  | 群馬県   |
| 12  | 埼玉県   |
| 13  | 千葉県   |
| 14  | 東京都   |
| 15  | 神奈川県 |
| 16  | 新潟県   |
| 17  | 富山県   |
| 18  | 石川県   |
| 19  | 福井県   |
| 20  | 山梨県   |
| 21  | 長野県   |
| 22  | 岐阜県   |
| 23  | 静岡県   |
| 24  | 愛知県   |
| 25  | 三重県   |
| 26  | 滋賀県   |
| 27  | 京都府   |
| 28  | 大阪府   |
| 29  | 兵庫県   |
| 30  | 奈良県   |
| 31  | 和歌山県 |
| 32  | 鳥取県   |
| 33  | 島根県   |
| 34  | 岡山県   |
| 35  | 広島県   |
| 36  | 山口県   |
| 37  | 徳島県   |
| 38  | 香川県   |
| 39  | 愛媛県   |
| 40  | 高知県   |
| 41  | 福岡県   |
| 42  | 佐賀県   |
| 43  | 長崎県   |
| 44  | 熊本県   |
| 45  | 大分県   |
| 46  | 宮崎県   |
| 47  | 鹿児島県 |
| 48  | 沖縄県   |

### Association

- has_many :items
- has_many :shipping_infos

## ActiveHash: category

| id  | name                  |
|-----|-----------------------|
| 1   | ---                   |
| 2   | メンズ                 |
| 3   | レディース              |
| 4   | ベビー・キッズ          |
| 5   | インテリア・住まい・小物  |
| 6   | 本・音楽・ゲーム        |
| 7   | おもちゃ・ホビー・グッズ  |
| 8   | 家電・スマホ・カメラ     |
| 9   | スポーツ・レジャー       |
| 10  | ハンドメイド            |
| 11  | その他                 |

### Association

- has_many :items

## ActiveHash: sales_status

| id  | name              |
|-----|-------------------|
| 1   | ---               |
| 2   | 新品・未使用        |
| 3   | 未使用に近い        |
| 4   | 目立った傷や汚れなし  |
| 5   | やや傷や汚れあり     |
| 6   | 傷や汚れあり        |
| 7   | 全体的に状態が悪い   |

### Association

- has_many :items

## ActiveHash: shipping_fee_status

| id  | name              |
|-----|-------------------|
| 1   | ---               |
| 2   | 着払い(購入者負担)   |
| 3   | 送料込み(出品者負担) |

### Association

- has_many :items

## ActiveHash: schedule_delivery

| id  | name              |
|-----|------------------ |
| 1   | ---               |
| 2   | 1~2日で発送        |
| 3   | 2~3日で発送        |
| 4   | 4~7日で発送        |

### Association

- has_many :items