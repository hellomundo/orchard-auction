class AddType < ActiveRecord::Migration
  def change
    add_column :touches, :type, :integer
  end
end
