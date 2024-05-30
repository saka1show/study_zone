class CreatedProblem < ApplicationRecord
  has_many :solved_problems
  has_many :favorites
  belongs_to :learner
  belongs_to :subject

  validates :problem, presence: true, length: { minimum: 1, maximum: 255 }
  validates :model_answer, presence: true, length: { minimum: 1, maximum: 100 }
  validates :explanation, presence: true, length: { minimum: 1, maximum: 255 }

  def favorited_by?(learner)
    favorites.exists?(learner_id: learner.id)
  end
end
