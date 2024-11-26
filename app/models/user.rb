class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  has_many :messages, foreign_key: 'sender_id'
  has_many :groups, through: :group_users
  
  # Define the relationship with ConversationWindows through the join table (conversation_window_users)
  has_many :conversation_window_users
  has_many :conversation_windows, through: :conversation_window_users
  has_many :statuses
  has_many :status_viewers
end
