class ApplicationJob < ActiveJob::Base
  def perform(user, chat)
    UserMailer.new_chat_invited_email(user, chat).deliver_later
  end
end
