class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :form
      t.decimal :amount, precision: 8, scale: 2
      t.references :buyer, index: true, foreign_key: true
      t.references :event, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
