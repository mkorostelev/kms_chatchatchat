class MessageObserver < ActiveRecord::Observer
  def before_save(message)
    message.chat.users.each do |user|
      users_message = message.users_messages.build(user: user)
      users_message.status = :readed if user == message.author
    end
  end
end
