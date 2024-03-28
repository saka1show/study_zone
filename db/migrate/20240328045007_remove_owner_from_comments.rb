class RemoveOwnerFromComments < ActiveRecord::Migration[6.1]
  def change
    remove_column :comments, :owner, :boolean
  end
end
