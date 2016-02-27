class CreatePledges < ActiveRecord::Migration
  def change
    create_table :pledges do |t|
      t.decimal :amount
      t.references :buyer, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
