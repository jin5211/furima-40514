FactoryBot.define do
  factory :user do
    transient do
      person { Gimei.name }
    end
    nickname              { Faker::FunnyName.name }
    email                 { Faker::Internet.email }
    password              { "#{Faker::Internet.password(min_length: 6)}1a" }
    password_confirmation { password }
    last_name             { person.last.kanji }
    first_name            { person.first.kanji }
    last_name_kana        { person.last.katakana }
    first_name_kana       { person.first.katakana }
    birth_date            { Faker::Date.between(from: '1930-01-01', to: 5.year.ago) }
  end
end
