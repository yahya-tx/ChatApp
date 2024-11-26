class Group < ApplicationRecord
    has_many :messages
    belongs_to :conversation_window, optional: true
    has_many :group_users
    has_many :users, through: :group_users
  end
  