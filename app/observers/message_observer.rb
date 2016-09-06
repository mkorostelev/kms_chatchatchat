class MessageObserver < ActiveRecord::Observer
  # def after_save(message)
  #   message.users_messages.clear
  #   a = []
  #   message.chat.users.each do |user|
  #     a << { user: user }
  #   end
  #   message.users_messages.create!(a)
  # end
end
