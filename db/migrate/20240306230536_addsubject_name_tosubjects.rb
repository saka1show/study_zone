class AddsubjectNameTosubjects < ActiveRecord::Migration[6.1]
  def change
    add_column :subjects, :subject_name, :string
  end
end
