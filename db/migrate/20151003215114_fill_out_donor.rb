class FillOutDonor < ActiveRecord::Migration
  def change
    add_column :donors, :first_name, :string
    add_column :donors, :last_name, :string
    add_column :donors, :address1, :string
    add_column :donors, :address2, :string
    add_column :donors, :city, :string
    add_column :donors, :state, :string
    add_column :donors, :zip, :integer
    add_column :donors, :status, :integer, default: 0
  end
end
