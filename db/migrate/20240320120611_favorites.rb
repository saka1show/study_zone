class Favorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
      t.integer "learner_id", null: false
      t.integer "created_problem_id", null: false
      t.timestamps
    end
  end
end
