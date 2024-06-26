class OrderShippingInfo
  include ActiveModel::Model
  attr_accessor :item_id, :user_id, :postal_code, :prefecture_id, :city, :address, :building, :phone_number, :token, :price

  with_options presence: true do
    validates :item_id
    validates :user_id
    validates :postal_code,
              format: { with: /\A[0-9]{3}-[0-9]{4}\z/ }
    validates :city
    validates :address
    validates :phone_number,
              format: { with: /\A\d{10,11}\z/ }
    validates :token
    validates :price
  end
  validates  :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }

  def save
    order = Order.create(item_id: item_id, user_id: user_id)
    ShippingInfo.create(order_id: order.id,
                        postal_code: postal_code,
                        prefecture_id: prefecture_id,
                        city: city,
                        address: address,
                        building: building,
                        phone_number: phone_number)
  end
end
