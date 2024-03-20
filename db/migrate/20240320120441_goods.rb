class Goods < ActiveRecord::Migration[6.1]
  def change
    drop_table :favorites
    drop_table :goods
  end
end
