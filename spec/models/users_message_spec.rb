require 'rails_helper'

RSpec.describe UsersMessage, type: :model do
  it { should validate_presence_of :user }

  it { should validate_presence_of :message }

  it { should validate_presence_of :status }

  it { should belong_to(:user) }

  it { should belong_to(:message) }
end
