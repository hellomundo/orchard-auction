class CreateDonors < ActiveRecord::Migration
  def change
    create_table :donors do |t|
      t.string :company

      t.timestamps null: false
    end
  end
end
