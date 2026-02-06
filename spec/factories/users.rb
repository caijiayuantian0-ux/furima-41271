FactoryBot.define do
  factory :user do
    nickname              { 'test' }
    email                 { 'test@examples' }
    password              { 'auiipw1200' }
    password_confirmation { password }

    last_name { '山田' }
    first_name { '太郎' }
    last_name_kana { 'ヤマダ' }
    first_name_kana { 'タロウ' }
    date_of_birth { Date.new(1990, 1, 1) }
  end
end
