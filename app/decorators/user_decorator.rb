class UserDecorator < Draper::Decorator
  delegate_all

  def as_json *args
    {
      id: id,
      full_name: full_name,
      email: email,
      unreaded_chats_count: unreaded_chats_count
    }
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def unreaded_chats_count
    Chat.joins(:users_messages).where(users_messages: { status: 0, user: context[:user] }).distinct.count
  end
end
