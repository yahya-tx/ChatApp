class ConversationWindowsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_conversation_window, only: [:show]

  def new
    @conversation_window = ConversationWindow.new
  end

  def index
    @conversation_windows = current_user.conversation_windows
    @recent_messages = Message.where("created_at > ? AND receiver_id = ?", 1.hour.ago, current_user.id)
                               .includes(:conversation_window)
                               .order(created_at: :desc)
                               .limit(10)
  
    range = params[:range] || '3_days'
    days_limit = case range
                 when '3_days' then 3
                 when '5_days' then 5
                 when '1_week' then 7
                 else 3
                 end
  
    @chart_data = current_user.conversation_windows
                              .where(created_at: Time.current.beginning_of_month..Time.current.end_of_month)
                              .group_by_day(:created_at, range: days_limit.days.ago..Time.current)
                              .count
  end
  

  def show
    return redirect_to conversation_windows_path, alert: 'Conversation not found' unless @conversation_window

    @messages = @conversation_window.messages.includes(:sender).order(created_at: :asc)
    @message = Message.new
  end
  def create
    @conversation_window = ConversationWindow.new(conversation_window_params)
  
    # Add current_user to user_ids if not already present
    unless @conversation_window.user_ids.include?(current_user.id)
      @conversation_window.user_ids << current_user.id
    end
  
    # Ensure the user is added to the conversation_window_users join table
    @conversation_window.users << current_user unless @conversation_window.users.include?(current_user)
  
    if @conversation_window.save
      redirect_to conversation_window_path(@conversation_window), notice: 'Conversation created successfully!'
    else
      render :new, alert: 'Failed to create conversation'
    end
  end
  
  

  private

  def set_conversation_window
    @conversation_window = ConversationWindow.find_by(id: params[:id])
    unless @conversation_window&.users&.include?(current_user)
      redirect_to conversation_windows_path, alert: "You don't have access to this conversation"
    end
  end

  def conversation_window_params
    params.require(:conversation_window).permit(:name, :chat_type, user_ids: [])
  end
end
