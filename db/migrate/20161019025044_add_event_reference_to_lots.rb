class AddEventReferenceToLots < ActiveRecord::Migration
  def change
    add_reference :lots, :event, index: true
  end
end
