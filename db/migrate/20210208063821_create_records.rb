class CreateRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :records do |t|
      
      t.integer :user_id, null: false
      t.string :name, null: false
      t.integer :color, null: false, default: 1
      t.time :start, null: false
      t.time :end

      t.timestamps
    end
  end
end
