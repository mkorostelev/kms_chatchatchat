class Api::MessagesController < ApplicationController
  include ActiveModel::Validations

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

  def collection
    @collection ||= Message.page(params[:page]).per(5)
  end
end
