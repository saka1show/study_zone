FactoryBot.define do
  factory :learner do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    name { Faker::Name.first_name }
    name_kana { Faker::Name.first_name }
  end
end