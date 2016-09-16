require 'rails_helper'

RSpec.describe NewChatInvitedEmailJob, type: :job do
  describe '#perform' do
    # def perform(user, chat)
    #   UserMailer.new_chat_invited_email(user, chat).deliver_later
    # end

    let(:user) { double }

    let(:chat) { double }

    before do
      expect(UserMailer).to receive(:new_chat_invited_email).with(user, chat) do
        double.tap { |a| expect(a).to receive(:deliver_later) }
      end
    end

    it { expect { subject.perform user, chat }.to_not raise_error }
  end
end
