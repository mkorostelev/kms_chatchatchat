class ChatDecorator < Draper::Decorator
  delegate_all
  decorates_association :users
  decorates_association :messages

  def as_json *args
    super only: [:id, :name],
          methods: context_methods
  end

  def context_methods
    @context_methods = [:users, :unread_messages_count]
    return @context_methods << :last_message if context[:collection]
    return @context_methods << :messages if context[:show]
    @context_methods
  end

  def unread_messages_count
    users_messages.where(user: context[:user], status: 0).size
  end

  def last_message
    messages.last
  end
end
