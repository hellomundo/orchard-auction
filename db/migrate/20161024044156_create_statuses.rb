class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.references :donor, index: true, foreign_key: true
      t.references :event, index: true, foreign_key: true
      t.integer :stage, default: 0

      t.timestamps null: false
    end
  end
end
