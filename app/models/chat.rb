class Chat < ApplicationRecord
  has_many :messages

  has_many :users_messages, through: :messages

  has_and_belongs_to_many :users

  validates :name, presence: true

  after_create :send_mail

  def send_mail
    users.each do |user|
      NewChatInvitedEmailJob.set(wait_until: DateTime.current + 15.seconds)
                                                     .perform_later(user, self)
    end
  end
end
