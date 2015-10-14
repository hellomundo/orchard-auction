class CreateTouches < ActiveRecord::Migration
  def change
    create_table :touches do |t|
      t.references :donor, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.text :note
      t.date :date

      t.timestamps null: false
    end
  end
end
