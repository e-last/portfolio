class AddCategoryIdToRecords < ActiveRecord::Migration[5.2]
  def change
    add_column :records, :category_id, :integer
  end
end
