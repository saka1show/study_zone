FactoryBot.define do
  factory :comment do
    association :learner
    association :solved_problem
    content { Faker::Lorem.characters(number:2) }
  end
end