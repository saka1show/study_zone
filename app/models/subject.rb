class Subject < ApplicationRecord
  has_many :created_problems

  validates :subject_name, presence: true
end
