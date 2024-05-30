class CreateGoods < ActiveRecord::Migration[6.1]
  def change
    create_table :goods do |t|
      t.integer :learner_id, null: false
      t.integer :created_problem_id, null: false

      t.timestamps
    end
  end
end
