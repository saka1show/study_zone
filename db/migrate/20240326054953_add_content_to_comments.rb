class AddContentToComments < ActiveRecord::Migration[6.1]
  def change
    add_column :comments, :content, :text, null: false
    remove_column :comments, :comment, :text
  end
end
