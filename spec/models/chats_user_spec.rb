require 'rails_helper'

RSpec.describe ChatsUser, type: :model do
  it { should validate_presence_of :user_id }

  it { should validate_presence_of :chat_id }

  #!!! it { should belong_to(:chats) }

  # it { should belong_to(:users) }
end
