class Comment < ApplicationRecord

  belongs_to :learner
  belongs_to :solved_problem

end
