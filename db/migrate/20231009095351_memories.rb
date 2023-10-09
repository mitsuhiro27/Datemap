class Memories < ActiveRecord::Migration[6.1]
  def change
    drop_table :memories
  end
end
