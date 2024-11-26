class ConversationWindow < ApplicationRecord
    has_many :messages, dependent: :destroy
    has_many :groups, dependent: :destroy
    has_many :conversation_window_users, dependent: :destroy  # Add this line to associate the join table
    has_many :users, through: :conversation_window_users
    has_many :statuses

    validates :name, presence: true
    validates :user_ids, presence: true, if: -> { chat_type == 'personal' }
  
    enum chat_type: { personal: 0, group_chat: 1 }
  end
  