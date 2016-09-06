class MessageDecorator < Draper::Decorator
  delegate_all
  decorates_association :author

  def as_json *args
    {
      id: id,
      text: text,
      author: author,
      status: message_status
    }
  end

  def message_status
    users_messages.find_by(user: context[:user]).status unless
                            users_messages.find_by(user: context[:user]).nil?
  end
end
