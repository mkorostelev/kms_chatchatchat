require 'rails_helper'

RSpec.describe Message, type: :model do
it { should validate_presence_of :text }

it { should validate_presence_of :author }

it { should belong_to(:author) }

it { should have_many(:users_messages) }

it { should have_many(:users).through(:users_messages) }
end
