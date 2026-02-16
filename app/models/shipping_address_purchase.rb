class ShippingAddressPurchase
  include ActiveModel::Model
  
  attr_accessor :postal_code, :prefecture_id, :city, :street_address, :building_name, :phone_number, :user_id, :good_id, :token
  
  with_options presence: true do
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: 'はハイフンを含めた正しい形式で入力してください' }
    validates :prefecture_id, numericality: { other_than: 1, message: "を選択してください" }
    validates :city
    validates :street_address
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'は10桁または11桁の数字で入力してください' }
    validates :user_id
    validates :good_id
    validates :token
  end
  
  def save
    # purchaseテーブルに保存
    purchase = Purchase.create(user_id: user_id, good_id: good_id)
    # shipping_addressesテーブルに保存
    ShippingAddress.create(
      purchase_id: purchase.id,
      postal_code: postal_code,
      prefecture_id: prefecture_id,
      city: city,
      street_address: street_address,
      building_name: building_name,
      phone_number: phone_number
    )
  end
end