class AddQuantityAvailableToLot < ActiveRecord::Migration
  def change
    add_column :lots, :quantity_available, :integer
  end
end
