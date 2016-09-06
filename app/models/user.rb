class User < ApplicationRecord
  has_many :users_messages

  has_many :messages, through: :users_messages

  has_and_belongs_to_many :chats

  #!!! has_many :messages, foreign_key: 'author_id'#, inverse_of: :author

  has_secure_password

  validates :first_name, presence: true

  validates :last_name, presence: true

  validates :email, presence: true, uniqueness: { case_sensitive: false }, email: true

  validates_uniqueness_of :token, allow_blank: true, allow_nil: true
end
