class RemoveStatusFromDonors < ActiveRecord::Migration
  def change
    remove_column :donors, :status, :integer
  end
end
