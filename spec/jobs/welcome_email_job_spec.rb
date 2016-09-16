require 'rails_helper'

RSpec.describe WelcomeEmailJob, type: :job do
  describe '#perform' do
    # def perform(user)
    #   UserMailer.welcome_email(user).deliver_now
    # end

    let(:user) { double }

    before do
      expect(UserMailer).to receive(:welcome_email).with(user) do
        double.tap { |a| expect(a).to receive(:deliver_now) }
      end
    end

    it { expect { subject.perform user }.to_not raise_error }
  end
end
