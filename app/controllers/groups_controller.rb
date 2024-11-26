class GroupsController < ApplicationController
  before_action :authenticate_user!

  def new
    @conversation_window = ConversationWindow.find(params[:conversation_window_id])
    @group = @conversation_window.groups.new
  end

  def create
    @conversation_window = ConversationWindow.find(params[:conversation_window_id])
    @group = @conversation_window.groups.new(group_params)
    debugger
    # Ensure current_user is always added to user_ids
    @group.user_ids = (group_params[:user_ids].map(&:to_i) + [current_user.id]).uniq
  
    if @group.save
      redirect_to conversation_windows_path, notice: "Group created successfully!"
    else
      flash[:alert] = "Failed to create group."
      render :new
    end
  end
  

  private

  def group_params
    params.require(:group).permit(:title, :description, :image, user_ids: [])
  end
end
