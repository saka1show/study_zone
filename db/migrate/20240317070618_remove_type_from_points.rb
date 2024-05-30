class RemoveTypeFromPoints < ActiveRecord::Migration[6.1]
  def change
    remove_column :points, :type, :boolean
    add_column :points, :owner, :boolean
  end
end
