FactoryBot.define do
  factory :point do
    association :learner
    association :solved_problem
  end
end