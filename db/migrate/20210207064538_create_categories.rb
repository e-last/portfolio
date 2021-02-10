class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.integer :user_id
      t.string :name, null: false, default: ""
      t.integer :color, null: false, default: 1

      t.timestamps
    end
  end
end
