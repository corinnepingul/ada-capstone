class AddForeignKeyToMoment < ActiveRecord::Migration
  def change
    add_foreign_key :moments, :users
  end
end
