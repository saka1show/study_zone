class Learner < ApplicationRecord
  has_many :created_problems
  has_many :solved_problems
  has_many :points
  has_many :comments
  has_many :goods

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
