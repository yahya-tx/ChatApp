class AddConversationWindowIdToMessages < ActiveRecord::Migration[7.1]
  def change
    add_column :messages, :conversation_window_id, :integer
  end
end
