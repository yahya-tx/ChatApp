class StatusViewer < ApplicationRecord
  belongs_to :status
  belongs_to :user

  validates :user, uniqueness: { scope: :status }
end
