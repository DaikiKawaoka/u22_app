class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :user_name
      t.string :email
      t.string :user_image
      t.string :user_comment
      t.integer :sex

      t.timestamps
    end
  end
end
