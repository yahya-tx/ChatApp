class StatusesController < ApplicationController
    before_action :set_conversation_window
  
    def new
      @status = @conversation_window.statuses.build
    end
  
    def create
      @status = @conversation_window.statuses.build(status_params)
      @status.user = current_user
      if @status.save
        redirect_to conversation_window_path(@conversation_window)
      else
        render :new  # Render 'new' if validation fails
      end
    end
  
    def show
      @status = Status.find(params[:id])

      @status.status_viewers.create(user: current_user, viewed_at: Time.current)
    end
  
    def index
      # Fetch all statuses for the current conversation window
      @statuses = @conversation_window.statuses.recent.order(created_at: :desc)
    end
  
    private
  
    def set_conversation_window
      @conversation_window = ConversationWindow.find(params[:conversation_window_id])
    end
  
    def status_params
      params.require(:status).permit(:content, :attachment, :status_type)
    end
  end
  