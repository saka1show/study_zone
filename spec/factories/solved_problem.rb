FactoryBot.define do
  factory :solved_problem do
    association :learner
    association :created_problem
    answer { Faker::Lorem.characters(number:1) }
  end
end