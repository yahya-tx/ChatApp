class Message < ApplicationRecord
    belongs_to :sender, class_name: 'User'
    belongs_to :receiver, class_name: 'User', optional: true
    belongs_to :group, optional: true
    belongs_to :conversation_window, optional: true
  
    has_one_attached :attachment
    validates :attachment, content_type: ['image/png', 'image/jpg', 'image/jpeg', 'video/mp4', 'video/quicktime']
    validates :content, presence: true, unless: -> { attachment.attached? }
  end
  