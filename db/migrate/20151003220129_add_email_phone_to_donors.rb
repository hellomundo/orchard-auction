class AddEmailPhoneToDonors < ActiveRecord::Migration
  def change
    add_column :donors, :email, :string
    add_column :donors, :phone, :string
  end
end
