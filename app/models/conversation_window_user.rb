class ConversationWindowUser < ApplicationRecord
  belongs_to :conversation_window
  belongs_to :user
end
