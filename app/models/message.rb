class Message < ApplicationRecord
  belongs_to :chat

  belongs_to :author, class_name: 'User'

  has_many :users_messages

  has_many :users, through: :users_messages

  validates :text, :author, :chat, presence: true
end
