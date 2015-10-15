class AddIndexToMoment < ActiveRecord::Migration
  def change
    add_index :moments, :user_id
  end
end
