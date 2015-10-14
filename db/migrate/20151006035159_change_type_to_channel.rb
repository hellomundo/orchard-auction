class ChangeTypeToChannel < ActiveRecord::Migration
  def change
    remove_column :touches, :type
    add_column :touches, :channel, :integer
  end
end
