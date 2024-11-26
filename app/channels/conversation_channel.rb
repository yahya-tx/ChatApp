class ConversationChannel < ApplicationCable::Channel
  def subscribed
    conversation_window = ConversationWindow.find_by(id: params[:conversation_window_id])
    
    if conversation_window
      stream_for conversation_window
    else
      reject
    end
  end
  
  
  def unsubscribed
    # Cleanup if necessary
  end

  def receive(data)
    conversation_window = ConversationWindow.find(params[:conversation_window_id])
    message = conversation_window.messages.create!(content: data['message'], user: current_user)
    
    broadcast_to(conversation_window, message: message.content, sender: current_user.name, created_at: message.created_at.strftime("%H:%M"), attachment_url: message.attachment.attached? ? rails_blob_path(message.attachment, disposition: "attachment") : nil)
  end
end
