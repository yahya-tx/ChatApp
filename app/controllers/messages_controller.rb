class MessagesController < ApplicationController
  before_action :set_conversation_window

  def create
    @message = @conversation_window.messages.new(message_params)
    @message.sender = current_user

    # Assign receiver_id (exclude the current_user from user_ids)
    @message.receiver_id = (@conversation_window.user_ids - [current_user.id]).first

    if @message.save!
      # Enqueue the broadcast job after the message is saved
      BroadcastMessageJob.perform_later(@message)

      # Redirect to the conversation window or render the form again
      redirect_to conversation_window_path(@conversation_window)
    else
      # Handle invalid message (optional)
      render 'conversation_windows/show'
    end
  end

  private

  def set_conversation_window
    @conversation_window = ConversationWindow.find(params[:conversation_window_id])
  end

  def message_params
    params.require(:message).permit(:content, :attachment, :conversation_window_id)
  end
end
