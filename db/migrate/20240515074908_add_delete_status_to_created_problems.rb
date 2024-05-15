class AddDeleteStatusToCreatedProblems < ActiveRecord::Migration[6.1]
  def change
    add_column :created_problems, :delete_status, :boolean, default: false
  end
end
