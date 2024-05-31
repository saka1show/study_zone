FactoryBot.define do
  factory :favorite do
    association :learner
    association :created_problem
  end
end