class AddEmailToBuyer < ActiveRecord::Migration
  def change
    add_column :buyers, :email, :string
  end
end
