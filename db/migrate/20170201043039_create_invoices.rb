class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.decimal :wintotal, precision: 8, scale: 2
      t.decimal :pledgetotal, precision: 8, scale: 2
      t.decimal :total, precision: 8, scale: 2
      t.references :invoice_status, index: true, foreign_key: true
      t.references :buyer, index: true, foreign_key: true
      t.references :event, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
