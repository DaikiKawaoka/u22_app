class AddPurchaseDateToThings < ActiveRecord::Migration[6.0]
  def change
    add_column :things, :purchase_date, :date
  end
end
