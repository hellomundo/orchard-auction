class AddEventsToBuyers < ActiveRecord::Migration
  def change
    add_reference :buyers, :event, index: true
  end
end
