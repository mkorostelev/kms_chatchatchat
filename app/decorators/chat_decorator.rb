class ChatDecorator < Draper::Decorator
  delegate_all
  decorates_association :users
  decorates_association :messages

  def as_json *args
    if context[:collection]
      {
        id: id,
        name: name,
        users: users,
        unread_messages_count: unread_messages_count,
        last_message: last_message
      }
    elsif context[:show]
      {
        id: id,
        name: name,
        users: users,
        unread_messages_count: unread_messages_count,
        messages: messages
      }
    else
      {
        id: id,
        name: name,
        users: users,
        unread_messages_count: unread_messages_count
      }
    end
  end

  def unread_messages_count
    users_messages.where(user: context[:user], status: 0).size
  end

  def last_message
    messages.last
  end
end
