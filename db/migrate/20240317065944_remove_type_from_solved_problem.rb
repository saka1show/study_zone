class RemoveTypeFromSolvedProblem < ActiveRecord::Migration[6.1]
  def change
    remove_column :solved_problems, :type, :boolean
    add_column :solved_problems, :owner, :boolean
  end
end
