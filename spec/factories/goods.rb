FactoryBot.define do
  factory :good do
    association :user

    name { 'テスト商品' }
    description { 'テスト説明' }
    category_id { 2 }
    condition_id { 2 }
    shipping_fee_id { 2 }
    prefecture_id { 2 }
    days_to_ship_id { 2 }
    price { 500 }

    after(:build) do |good|
      good.image.attach(
        io: File.open(Rails.root.join('spec/fixtures/files/test.png')),
        filename: 'test.png',
        content_type: 'image/png'
      )
    end
  end
end
