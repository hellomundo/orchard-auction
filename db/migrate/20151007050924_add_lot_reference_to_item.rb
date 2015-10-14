class AddLotReferenceToItem < ActiveRecord::Migration
  def change
    add_reference :items, :lot, index: true
  end
end
