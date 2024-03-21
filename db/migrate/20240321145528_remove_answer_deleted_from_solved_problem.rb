class RemoveAnswerDeletedFromSolvedProblem < ActiveRecord::Migration[6.1]
  def change
    remove_column :solved_problems, :answer_deleted, :boolean
  end
end
