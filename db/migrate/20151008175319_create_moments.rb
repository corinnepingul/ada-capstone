class CreateMoments < ActiveRecord::Migration
  def change
    create_table :moments do |t|
      t.date :date
      t.text :body
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
