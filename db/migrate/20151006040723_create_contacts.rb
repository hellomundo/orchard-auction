class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.references :donor, index: true, foreign_key: true
      t.text :note
      t.integer :channel
      t.date :contacted_on

      t.timestamps null: false
    end
  end
end
