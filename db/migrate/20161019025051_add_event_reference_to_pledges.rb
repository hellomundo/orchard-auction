class AddEventReferenceToPledges < ActiveRecord::Migration
  def change
    add_reference :pledges, :event, index: true
  end
end
