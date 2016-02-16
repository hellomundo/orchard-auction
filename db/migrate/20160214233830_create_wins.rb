class CreateWins < ActiveRecord::Migration
  def change
    create_table :wins do |t|
      t.references :buyer, index: true, foreign_key: true
      t.references :item, index: true, foreign_key: true
      t.decimal :price, :precision => 8, :scale => 2

      t.timestamps null: false
    end
  end
end
