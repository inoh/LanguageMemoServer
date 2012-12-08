class CreateTagRelations < ActiveRecord::Migration
  def change
    create_table :tag_relations do |t|
      t.integer :tag_id
      t.integer :memo_id

      t.timestamps
    end
  end
end
