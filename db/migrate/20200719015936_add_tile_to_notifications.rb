class AddTileToNotifications < ActiveRecord::Migration[6.0]
  def change
    add_column :notifications, :title, :string
  end
end
