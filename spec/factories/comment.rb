FactoryBot.define do
  factory :subject do
    association :learner
    association :solved_problem
    content { Faker::Lorem.characters(number:1) }
  end
end