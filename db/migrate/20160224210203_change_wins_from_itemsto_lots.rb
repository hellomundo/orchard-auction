class ChangeWinsFromItemstoLots < ActiveRecord::Migration
  def change
    remove_reference :wins, :item, index: true, foreign_key: true
    add_reference :wins, :lot, index: true, foreign_key: true
  end
end
