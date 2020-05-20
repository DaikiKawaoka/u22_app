class AddIndexToUsersUserName < ActiveRecord::Migration[6.0]
  def change
    add_index :users, :user_name, unique: true
  end
end
