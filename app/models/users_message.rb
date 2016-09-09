class UsersMessage < ApplicationRecord
  enum status: [:unreaded, :readed]

  belongs_to :user, dependent: :destroy

  belongs_to :message, dependent: :destroy

  has_many :chat, through: :message

  validates :user, :message, :status, presence: true
end
