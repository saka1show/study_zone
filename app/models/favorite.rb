class Favorite < ApplicationRecord

  belongs_to :learner
  belongs_to :created_problem

  validates :learner_id, uniqueness: {scope: :created_problem_id}

end
