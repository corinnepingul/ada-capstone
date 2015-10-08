class ChangeMomentColumnsToNull < ActiveRecord::Migration
  def change
    change_column_null :moments, :date, false
    change_column_null :moments, :body, false
    change_column_null :moments, :user_id, false
  end
end
