class AddCountryCodeToUsersModel < ActiveRecord::Migration
  def change
    add_column :users, :country_code, :string, { null: false }
  end
end
