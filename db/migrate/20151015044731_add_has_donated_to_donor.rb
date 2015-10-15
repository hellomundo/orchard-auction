class AddHasDonatedToDonor < ActiveRecord::Migration
  def change
    add_column :donors, :has_donated, :boolean
  end
end
