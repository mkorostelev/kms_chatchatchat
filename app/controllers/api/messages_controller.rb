class Api::MessagesController < ApplicationController
  private

  def parent
    @parent ||= Chat.find(params[:chat_id])
  end

  def build_resource
    @message = parent.messages.new resource_params
  end

  def resource
    @message ||= Message.find(params[:id])
  end

  def resource_params
    params.require(:message).permit(:text).merge(author: current_user)
  end
end
