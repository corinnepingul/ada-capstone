class CreateJoinTableMomentTag < ActiveRecord::Migration
  def change
    create_join_table :moments, :tags do |t|
      t.index :moment_id
      t.index :tag_id
    end
  end
end
