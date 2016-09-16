class NewMassageEmailJob < ApplicationJob
  queue_as :default

  def perform(user, chat)
    UserMailer.new_message_email(user, chat).deliver_now
  end
end
