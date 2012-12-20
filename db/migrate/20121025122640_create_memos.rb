class CreateMemos < ActiveRecord::Migration
  def change
    create_table :memos do |t|
      t.string :title
      t.text :note

      t.timestamps
    end
  end
end
