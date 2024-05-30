FactoryBot.define do
  factory :subject do
    subject_name { Faker::Lorem.characters(number:1) }
  end
end