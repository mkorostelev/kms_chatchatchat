class UsersMessage < ApplicationRecord
  enum status: [:unreaded, :readed]

  belongs_to :user, dependent: :destroy

  belongs_to :message, dependent: :destroy

  validates :user, :message, :status, presence: true
end
