class AddConversationWindowIdToGroups < ActiveRecord::Migration[7.1]
  def change
    add_column :groups, :conversation_window_id, :integer
  end
end
