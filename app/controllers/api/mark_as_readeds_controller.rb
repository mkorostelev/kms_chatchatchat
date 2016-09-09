class Api::MarkAsReadedsController < ApplicationController
  def show
    Chat.find(params[:chat_id]).users_messages.where(user: current_user)
                                              .update_all(status: 1)
    head:ok
  end
end
