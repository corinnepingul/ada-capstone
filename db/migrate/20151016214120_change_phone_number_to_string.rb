class ChangePhoneNumberToString < ActiveRecord::Migration
  def change
    change_column :users, :phone_number, :string, { null: false }
  end
end
