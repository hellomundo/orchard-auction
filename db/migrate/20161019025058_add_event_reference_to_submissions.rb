class AddEventReferenceToSubmissions < ActiveRecord::Migration
  def change
    add_reference :submissions, :event, index: true
  end
end
