FactoryBot.define do
  factory :order_shipping_info do
    postal_code   { "#{Faker::Number.number(digits: 3)}-#{Faker::Number.number(digits: 4)}"}
    prefecture_id { Faker::Number.within(range: 2..48) }
    city          { Gimei.city.kanji }
    address       { Gimei.town.to_s }
    building      { Faker::Company.name }
    phone_number  { Faker::Number.number(digits: 11) }
    token         { Faker::Blockchain::Aeternity.address }
    price         { Faker::Number.within(range: 300..9_999_999) }
  end
end