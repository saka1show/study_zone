class SolvedProblem < ApplicationRecord

  belongs_to :learner
  belongs_to :created_problem
  has_many :points
  has_many :comments
  accepts_nested_attributes_for :points, reject_if: :all_blank, allow_destroy: true

end
