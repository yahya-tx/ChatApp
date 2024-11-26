class CreateConversationWindowUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :conversation_window_users do |t|
      t.references :conversation_window, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
