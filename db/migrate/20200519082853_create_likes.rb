class CreateLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :likes do |t|
      t.integer :user_id
      t.integer :thing_id

      t.timestamps

      t.index :user_id
      t.index :thing_id
      t.index [:user_id, :thing_id], unique: true
    end
  end
end
