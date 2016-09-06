class Chat < ApplicationRecord
  has_many :messages

  has_many :users_messages, through: :messages

  has_and_belongs_to_many :users

  validates :name, presence: true
end
