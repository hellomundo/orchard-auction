class AddEventReferenceToItems < ActiveRecord::Migration
  def change
    add_reference :items, :event, index: true
  end
end
