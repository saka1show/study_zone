class CreateCreatedProblems < ActiveRecord::Migration[6.1]
  def change
    create_table :created_problems do |t|

      t.integer :learner_id, null: false
      t.integer :subject_id, null: false
      t.text :problem, null: false
      t.text :model_answer, null: false
      t.text :explanation, null: false
      t.boolean :is_release, null: false, default: true

      t.timestamps
    end
  end
end
