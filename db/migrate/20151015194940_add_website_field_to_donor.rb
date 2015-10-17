class AddWebsiteFieldToDonor < ActiveRecord::Migration
  def change
    add_column :donors, :website, :string
  end
end
