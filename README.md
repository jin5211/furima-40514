# DB 設計

## users table

| Column             | Type                | Options                                                |
|--------------------|---------------------|--------------------------------------------------------|
| nickname           | string              | null: false                                            |
| email              | string              | null: false, unique: true                              |
| encrypted_password | string              | null: false, format: {with: /\A[a-zA-Z0-9]+\z/}        |
| last_name          | string              | null: false, format: {with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/} |
| first_name         | string              | null: false, format: {with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/} |
| last_name_kana     | string              | null: false, format: {with: /\A[ァ-ヴー]+\z/}           |
| first_name_kana    | string              | null: false, format: {with: /\A[ァ-ヴー]+\z/}           |
| birth_year         | integer             | null: false                                            |
| birth_month        | integer             | null: false                                            |
| birth_day          | integer             | null: false                                            |

### Association

* has_many :items
* has_many :orders
* has_many :shippingInfos


## items table

| Column                              | Type       | Options                        |
|-------------------------------------|------------|--------------------------------|
| item_name                           | string     | null: false                    |
| item_info                           | text       | null: false                    |
| item_category                       | text       | null: false                    |
| item_sales_status                   | text       | null: false,                   |
| item_shipping_fee_status            | text       | null: false,                   |
| item_prefecture                     | text       | null: false,                   |
| item_scheduled_delivery             | text       | null: false,                   |
| item_price                          | integer    | null: false,                   |
| user                                | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :order
- has_one :shippingInfo

## orders table

| Column      | Type       | Options                        |
|-------------|------------|--------------------------------|
| item        | references | null: false, foreign_key: true |
| user        | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :shippingInfo

## shippingInfos table

| Column       | Type       | Options                                          |
|--------------|------------|--------------------------------------------------|
| item         | references | null: false, foreign_key: true                   |
| user         | references | null: false, foreign_key: true                   |
| postal_code  | text       | null: false, format: {with: /\A\d{3}[-]\d{4}\z/} |
| prefecture   | text       | null: false                                      |
| city         | text       | null: false                                      |
| address      | text       | null: false                                      |
| building     | text       |                                                  |
| phone_number | text       | null: false, format: {with: /\A\d{11}\z/}        |

### Association

- belongs_to :user
- belongs_to :item
- belongs_to :order
