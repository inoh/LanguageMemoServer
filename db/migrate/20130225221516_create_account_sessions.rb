class CreateAccountSessions < ActiveRecord::Migration
  def change
    create_table :account_sessions do |t|
      t.string :parse_object_id
      t.string :session_token

      t.timestamps
    end
  end
end
