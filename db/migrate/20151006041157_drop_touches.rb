class DropTouches < ActiveRecord::Migration
  def change
    drop_table :touches
  end
end
