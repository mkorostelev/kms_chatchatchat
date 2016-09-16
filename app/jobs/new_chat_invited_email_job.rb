class NewChatInvitedEmailJob < ApplicationJob
  queue_as :default

  def perform(user, chat)
    UserMailer.new_chat_invited_email(user, chat).deliver_later
  end
end
