class Comment < ApplicationRecord

  belongs_to :learner
  belongs_to :solved_problem

  validates :content, presence: true, length: { minimum: 2, maximum: 255 }
end
