class AddTableToLot < ActiveRecord::Migration
  def change
    add_column :lots, :table_number, :integer
  end
end
