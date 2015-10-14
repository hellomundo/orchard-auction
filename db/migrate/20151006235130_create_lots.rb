class CreateLots < ActiveRecord::Migration
  def change
    create_table :lots do |t|
      t.string :name
      t.text :description

      t.timestamps null: false
    end
  end
end
