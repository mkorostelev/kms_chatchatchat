class Api::ChatsController < ApplicationController
  include ActiveModel::Validations

  def mark_as_readed
    Chat.find(params[:chat_id]).users_messages.where(user: current_user)
                                              .update_all(status: 1)
    head:ok
  end

  private

  def build_resource
    @chat = Chat.new resource_params
  end

  def resource
    @chat ||= Chat.find(params[:id])
  end

  def resource_params
    params.require(:chat).permit(:name, user_ids: [])
  end

  def collection
    @collection ||= Chat.page(params[:page]).per(5)
  end
end
