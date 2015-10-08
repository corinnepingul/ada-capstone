class ChangeUserColumnsToNull < ActiveRecord::Migration
  def change
    change_column_null :users, :username, false
    change_column_null :users, :email, false
    change_column_null :users, :password_digest, false
    change_column_null :users, :phone_number, false
  end
end
