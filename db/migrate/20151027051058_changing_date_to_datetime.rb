class ChangingDateToDatetime < ActiveRecord::Migration
  def change
    change_column :moments, :date, :datetime
  end
end
