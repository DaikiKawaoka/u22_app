class CreateKeeps < ActiveRecord::Migration[6.0]
  def change
    create_table :keeps do |t|
      t.integer :user_id , null: false
      t.integer :thing_id , null: false

      t.timestamps

      t.index :user_id
      t.index :thing_id
      t.index [:user_id, :thing_id], unique: true
    end
  end
end
