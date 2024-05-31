FactoryBot.define do
  factory :learner do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    name { Faker::Name.unique.first_name }
    name_kana { Faker::Name.unique.first_name }
    after(:build) do |learner|
      while learner.name.length < 2 || learner.name_kana.length < 2
        learner.name = Faker::Name.unique.first_name
        learner.name_kana = Faker::Name.unique.first_name
      end
    end
  end
end