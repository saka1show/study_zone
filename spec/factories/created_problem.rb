FactoryBot.define do
  factory :created_problem do
    association :learner
    association :subject
    problem { Faker::Lorem.characters(number:1) }
    model_answer { Faker::Lorem.characters(number:1) }
    explanation { Faker::Lorem.characters(number:1) }
  end
end