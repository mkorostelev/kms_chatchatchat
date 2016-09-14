class Api::MarkAsReadedsController < ApplicationController
  def show
    Chat.find(params[:chat_id]).users_messages.unreaded.where(user: current_user)
                                              .update_all(status: :readed)
    head:ok
  end
end
