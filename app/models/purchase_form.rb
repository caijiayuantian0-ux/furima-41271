class PurchaseForm
  include ActiveModel::Model
  
  attr_accessor :user_id, :good_id, 
                :postal_code, :prefecture_id, :city, :street_address, :building_name, :phone_number
  
    VALID_POSTAL_REGEX =/\A\d{3}-\d{4}\z/
    VALID_PHONE_REGEX =/\A\d{10,11}\z/

    validates :postal_code,  presence: true,
    format: {
       with: VALID_POSTAL_REGEX 
      }
    validates :prefecture_id, presence: true, numericality: { other_than: 1, }
    validates :city, :street_address ,  presence: true
    validates :phone_number,  presence: true,
    format: {
       with: VALID_PHONE_REGEX
       }
    validates :user_id, :good_id,  presence: true

  def save
    return false unless valid?

    ActiveRecord::Base.transaction do
      purchase = Purchase.create!(user_id: user_id, good_id: good_id)
      purchase.create_shipping_address!(
        postal_code: postal_code,
        prefecture_id: prefecture_id,
        city: city,
        street_address: street_address,
        building_name: building_name,
        phone_number: phone_number
      )
    end

    true
  rescue ActiveRecord::RecordInvalid
    false
  end
end
