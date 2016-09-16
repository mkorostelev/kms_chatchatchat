class MessageObserver < ActiveRecord::Observer
  def before_save(message)
    return unless message.is_a?(Message)
    message.chat.users.each do |user|
      users_message = message.users_messages.build(user: user)

      users_message.status = :readed if user == message.author

      NewMassageEmailJob.set(wait_until: DateTime.current + 15.seconds)
                    .perform_later(user, message.chat) if user != message.author
    end
    # message.users_messages.select{ |a| a.user_id == message.author_id }
    #                                     .first.status = :readed
  end
end
