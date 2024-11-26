class BroadcastMessageJob < ApplicationJob
  queue_as :default

  def perform(message)
    conversation_window = message.conversation_window
    users = conversation_window.users

    users.each do |user|
      ActionCable.server.broadcast(
        "conversation_channel_#{conversation_window.id}", 
        {
          sender: message.sender.name,
          content: message.content,
          sender_id: message.sender.id,
          receiver_id: message.receiver_id,
          attachment_url: message.attachment.attached? ? Rails.application.routes.url_helpers.url_for(message.attachment) : nil,
          created_at: message.created_at.strftime('%H:%M')
        }
      )
    end
  end
end
