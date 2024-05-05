class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  with_options presence: true do
    validates :name, :info, :price, :image
    validates :prefecture_id
    validates :category_id
    validates :sales_status_id
    validates :shipping_fee_status_id
    validates :schedule_delivery_id
  end

  validates_numericality_of :price, only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999

  belongs_to :user
  has_one_attached :image
  has_one    :order

  belongs_to :prefecture
  belongs_to :category
  belongs_to :sales_status
  belongs_to :shipping_fee_status
  belongs_to :schedule_delivery
  validates  :prefecture_id,          numericality: { other_than: 1, message: "can't be blank" }
  validates  :category_id,            numericality: { other_than: 1, message: "can't be blank" }
  validates  :sales_status_id,        numericality: { other_than: 1, message: "can't be blank" }
  validates  :shipping_fee_status_id, numericality: { other_than: 1, message: "can't be blank" }
  validates  :schedule_delivery_id,   numericality: { other_than: 1, message: "can't be blank" }
end
