class AddHourToRecords < ActiveRecord::Migration[5.2]
  def change
    add_column :records, :hour, :datetime
  end
end
