class CreateThings < ActiveRecord::Migration[6.0]
  def change
    create_table :things do |t|
      t.integer :user_id
      t.string :thing_image
      t.string :thing_comment
      t.integer :thing_frequency
      t.integer :thing_assessment
      t.integer :thing_type
      t.string :thing_name
      t.boolean :thing_shear
      t.boolean :thing_favorite
      t.integer :thing_price
      t.integer :thing_number
      t.integer :thing_number_remaining
      t.string :thing_purchase_place
      t.string :thing_maker
      t.string :thing_memo

      t.timestamps
    end
  end
end
