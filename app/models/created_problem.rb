class CreatedProblem < ApplicationRecord

  has_many :solved_problems
  belongs_to :learner
  belongs_to :subject

end
