class CreatePoints < ActiveRecord::Migration[6.1]
  def change
    create_table :points do |t|
      t.integer :learner_id, null: false
      t.integer :solved_problem_id, null: false
      t.integer :point, null: false
      t.boolean :type, null: false, default: true

      t.timestamps
    end
  end
end
