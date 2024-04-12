class AddAnswerDeletedToSolvedProblem < ActiveRecord::Migration[6.1]
  def change
    add_column :solved_problems, :answer_deleted, :boolean
  end
end
