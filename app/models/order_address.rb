class OrderAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture, :city, :addresses, :building, :phone_number, :user_id, :item_id, :token

  with_options presence: true do
    validates :user_id
    validates :token
    validates :item_id
    validates :city
    validates :addresses
    validates :phone_number,
              format: { with: /\A\d{10,11}\z/, message: 'Invalid. Please enter only digits in half-width characters.' }
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
  end
  validates :prefecture, numericality: { other_than: 0, message: "can't be blank" }


  def save
    order = Order.create(user_id:, item_id:)
    Address.create(postal_code:, prefecture:, city:, addresses:, building:,
                   phone_number:, order_id: order.id)
  end
end