class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.integer :memo_id
      t.string :filename

      t.timestamps
    end
  end
end
