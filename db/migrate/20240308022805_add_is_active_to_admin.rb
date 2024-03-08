class AddIsActiveToAdmin < ActiveRecord::Migration[6.1]
  def change
    add_column :admins, :is_active, :boolean
  end
end
