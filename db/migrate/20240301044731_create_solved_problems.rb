class CreateSolvedProblems < ActiveRecord::Migration[6.1]
  def change
    create_table :solved_problems do |t|

      t.integer :learner_id, null: false
      t.integer :created_problem_id, null: false
      t.text :answer, null: false
      t.boolean :answer_status, null: false, default: true

      t.timestamps
    end
  end
end
