FactoryBot.define do
  factory :purchase_form do
    postal_code     { "123-4567" }
    prefecture_id   { 2 }
    city            { "横浜市緑区" }
    street_address  { "青山1-1-1" }
    building_name   { "柳ビル103" }
    phone_number    { "09012345678" }

    trait :with_user_and_good do
      after(:build) do |form|
        user = FactoryBot.create(:user)
        good = FactoryBot.create(:good)
        form.user_id = user.id
        form.good_id = good.id
      end
    end
  end
end
