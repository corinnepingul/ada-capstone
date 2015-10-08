class ChangeTagColumnToNull < ActiveRecord::Migration
  def change
    change_column_null :tags, :body, false
  end
end
