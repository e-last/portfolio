class ChangeDataStartToRecords < ActiveRecord::Migration[5.2]
  def change
    change_column :records, :start, :datetime
  end
end
