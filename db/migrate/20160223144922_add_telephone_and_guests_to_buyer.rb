class AddTelephoneAndGuestsToBuyer < ActiveRecord::Migration
  def change
    add_column :buyers, :telephone, :string
    add_column :buyers, :guests, :integer
  end
end
