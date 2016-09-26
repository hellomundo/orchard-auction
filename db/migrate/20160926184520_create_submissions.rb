class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.string :business
      t.string :contact
      t.string :email
      t.string :telephone
      t.string :item
      t.integer :category
      t.integer :format
      t.decimal :fmv, :precision => 8, :scale => 2
      t.text :description
      t.text :restrictions

      t.timestamps null: false
    end
  end
end
