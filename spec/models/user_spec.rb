require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_secure_password }

  it { should validate_presence_of :first_name }

  it { should validate_presence_of :last_name }

  it { should validate_presence_of :email }

  it { should validate_uniqueness_of :token }

  it { should have_db_index(:token).unique(true) }

  it { should validate_uniqueness_of(:email).case_insensitive }

  it { should_not allow_value('test').for(:email) }

  it { should allow_value('test@test.com').for(:email) }

  it { should have_many(:users_messages) }

  it { should have_many(:messages).through(:users_messages) }

  it { should have_and_belong_to_many(:chats) }

  describe '#send_mail' do
    # WelcomeEmailJob.set(wait_until: DateTime.current + 15.seconds).perform_later(self)

    before do
      expect(WelcomeEmailJob).to receive(:set)
                            .with(wait_until: DateTime.current + 15.seconds) do
        double.tap do |a|
          expect(a).to receive(:perform_later).with(subject)
        end
      end
    end
    it { expect { subject.send :send_mail }.to_not raise_error }
  end


end
