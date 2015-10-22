class AddColumnToMomentModel < ActiveRecord::Migration
  def change
    add_column :moments, :media_url, :string
  end
end
