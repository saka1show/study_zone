class Learner < ApplicationRecord
  has_many :created_problems
  has_many :solved_problems
  has_many :points
  has_many :comments
  has_many :favorites

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { minimum: 2, maximum: 10 }
  validates :name_kana, presence: true, length: { minimum: 2, maximum: 50 }
end
