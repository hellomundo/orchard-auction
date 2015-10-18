class AddFieldsToLot < ActiveRecord::Migration
  def change
    add_column :lots, :opening_price, :float, :precision => 8, :scale => 2
    add_column :lots, :bid_increment, :float, :precision => 8, :scale => 2
    add_column :lots, :buy_now_price, :float, :precision => 8, :scale => 2
  end
end
