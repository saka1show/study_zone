class AddAnswerDeletedToSolvedProblems < ActiveRecord::Migration[6.1]
  def change
    add_column :solved_problems, :answer_deleted, :boolean, default: false, null: false
  end
end
