class ChatsUser < ApplicationRecord
  belongs_to :users

  belongs_to :chats

  validates :user_id, :chat_id, presence: true
end
