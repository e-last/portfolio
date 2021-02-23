class ChangeDataHourToRecords < ActiveRecord::Migration[5.2]
  def change
    change_column :records, :hour, :integer
  end
end
