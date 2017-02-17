class AddIsAvailableToItems < ActiveRecord::Migration
  def change
    add_column :items, :is_available, :boolean, default: true
  end
end
