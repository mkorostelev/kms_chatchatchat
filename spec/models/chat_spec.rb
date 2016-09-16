require 'rails_helper'

RSpec.describe Chat, type: :model do
  it { should validate_presence_of :name }

  #!!! it { should have_many(:messages) }

  it { should have_many(:users_messages).through(:messages) }

  it { should have_and_belong_to_many(:users) }

  describe '#send_mail' do
    # users.each do |user|
    #   NewChatInvitedEmailJob.set(wait_until: DateTime.current + 15.seconds)
    #                                                  .perform_later(user, self)
    # end

    let(:user1) { stub_model User }

    let(:user2) { stub_model User }

    before { expect(subject).to receive(:users).and_return([user1, user2]) }

    before do
      expect(NewChatInvitedEmailJob).to receive(:set)
                            .with(wait_until: DateTime.current + 15.seconds) do
        double.tap do |a|
          expect(a).to receive(:perform_later).with(user1, subject)
        end
      end
    end

    before do
      expect(NewChatInvitedEmailJob).to receive(:set)
                            .with(wait_until: DateTime.current + 15.seconds) do
        double.tap do |a|
          expect(a).to receive(:perform_later).with(user2, subject)
        end
      end
    end
    it { expect { subject.send :send_mail }.to_not raise_error }
  end
end
