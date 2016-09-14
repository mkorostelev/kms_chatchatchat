class Api::ChatsController < ApplicationController
  def create
    super

    resource.users.each do |user|
      # email_message = UserMailer.new_chat_invited_email(user, resource)
      ApplicationJob.set(wait_until: DateTime.current + 15.seconds).perform_later(user, resource)
    end
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
