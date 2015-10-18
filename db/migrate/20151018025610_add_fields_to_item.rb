class AddFieldsToItem < ActiveRecord::Migration
  def change
    add_column :items, :restrictions, :text
    add_column :items, :format, :integer, default: 0
    add_column :items, :opening_price, :float, :precision => 8, :scale => 2
  end
end
