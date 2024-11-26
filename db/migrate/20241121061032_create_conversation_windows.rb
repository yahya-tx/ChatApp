class CreateConversationWindows < ActiveRecord::Migration[7.1]
  def change
    create_table :conversation_windows do |t|
      t.string :name
      t.integer :chat_type
      t.integer :user_ids, default: [], array: true

      t.timestamps
    end
  end
end
