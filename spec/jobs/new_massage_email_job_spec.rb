require 'rails_helper'

RSpec.describe NewMassageEmailJob, type: :job do
  describe '#perform' do
    # def perform(user, chat)
    #   UserMailer.new_message_email(user, chat).deliver_now
    # end

    let(:user) { double }

    let(:chat) { double }

    before do
      expect(UserMailer).to receive(:new_message_email).with(user, chat) do
        double.tap { |a| expect(a).to receive(:deliver_now) }
      end
    end

    it { expect { subject.perform user, chat }.to_not raise_error }
  end
end
