class CreatedProblem < ApplicationRecord

  has_many :solved_problems
  has_many :favorites
  belongs_to :learner
  belongs_to :subject

  def favorited_by?(learner)
    favorites.exists?(learner_id: learner.id)
  end

end
