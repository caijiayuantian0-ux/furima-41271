class Good < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  # Validations
  VALID_PRICE_REGEX = /\A[0-9]+\z/


  validates :image, presence: true
  validates :name, presence: true, length: { maximum: 40 }
  validates :description, presence: true, length: { maximum: 1000 }
  validates :price, presence: true


  with_options numericality: { other_than: 1, message: "を選択してください" } do
    validates :category_id
    validates :condition_id
    validates :shipping_fee_id
    validates :prefecture_id
    validates :days_to_ship_id
  end

  validates :price,
            format: { 
              with: VALID_PRICE_REGEX
            },
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 300,
              less_than_or_equal_to: 9_999_999
            }

  # Associations
  belongs_to :user
  has_one :purchase
  has_one_attached :image
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_fee
  belongs_to :prefecture
  belongs_to :days_to_ship
end
