class Status < ApplicationRecord
  belongs_to :user
  belongs_to :conversation_window
  has_many :status_viewers, dependent: :destroy
  has_one_attached :attachment # For image or video attachment

  enum status_type: { text: 'text', image: 'image', video: 'video' }
  scope :recent, -> { where('created_at >= ?', 24.hours.ago) }

  # Method to check if a user has seen the status
  def seen_by?(user)
    status_viewers.exists?(user: user)
  end
end
