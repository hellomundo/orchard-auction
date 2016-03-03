class AddIsPaidToBuyer < ActiveRecord::Migration
  def change
    add_column :buyers, :is_paid, :boolean, null: false, default: false
  end
end
