class AddUserNotificationToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :user_notification, :boolean
  end
end
