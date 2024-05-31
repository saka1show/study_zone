class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.integer :learner_id, null: false
      t.integer :solved_problem_id, null: false
      t.text :comment, null: false

      t.timestamps
    end
  end
end
