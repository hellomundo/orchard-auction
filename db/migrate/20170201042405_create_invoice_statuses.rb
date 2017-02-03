class CreateInvoiceStatuses < ActiveRecord::Migration
  def change
    create_table :invoice_statuses do |t|
      t.integer :status

      t.timestamps null: false
    end
  end
end
