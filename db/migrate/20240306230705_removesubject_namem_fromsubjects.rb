class RemovesubjectNamemFromsubjects < ActiveRecord::Migration[6.1]
  def change
    remove_column :subjects, :subject_namem, :string
  end
end
