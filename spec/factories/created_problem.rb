FactoryBot.define do
  factory :created_problem do
    association :learner
    problem { Faker::Lorem.characters(number:1) }
    model_answer { Faker::Lorem.characters(number:1) }
    explanation { Faker::Lorem.characters(number:1) }
    subject_id { rand(1..7) }
  end
end