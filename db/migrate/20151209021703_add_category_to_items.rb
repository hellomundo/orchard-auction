class AddCategoryToItems < ActiveRecord::Migration
  def change
    add_column :items, :category, :integer, default: 0
  end
end
