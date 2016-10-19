class AddEventReferenceToWins < ActiveRecord::Migration
  def change
    add_reference :wins, :event, index: true
  end
end
