FactoryBot.define do
  factory :admin do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    name { Faker::Name.unique.first_name }
    after(:build) do |admin|
      while admin.name.length < 2
        learner.name = Faker::Name.unique.first_name
      end
    end
  end
end