class ChangeDataEndToRecords < ActiveRecord::Migration[5.2]
  def change
    change_column :records, :end, :datetime
  end
end
