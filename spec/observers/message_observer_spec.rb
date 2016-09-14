require 'rails_helper'

RSpec.describe MessageObserver, type: :observer do
  let(:user1) { stub_model User }

  let(:user2) { stub_model User }

  let(:chat) { stub_model Chat, id: 1, name: 'Name' }

  let(:message) { stub_model Message, text: 'text', author: user1, chat: chat }

  subject { described_class.send(:new) }

  describe '#before_save' do
    # message.chat.users.each do |user|
    #   users_message = message.users_messages.build(user: user)
    #   users_message.status = :readed if user == message.author
    #   UserMailer.new_message_email(user, message.chat).deliver_now if user != message.author
    # end

    let(:users_message) { stub_model UsersMessage }

    before do
      expect(message).to receive(:chat) do
        double.tap do |a|
          expect(a).to receive(:users).and_return([user1, user2])
        end
      end
    end

    before do
      expect(message).to receive(:users_messages) do
        double.tap do |a|
          expect(a).to receive(:build).with(user: user1).and_return(users_message)
        end
      end
    end

    before do
      expect(message).to receive(:users_messages) do
        double.tap do |a|
          expect(a).to receive(:build).with(user: user2)
        end
      end
    end

    before { expect(message).to receive(:author).exactly(4).and_return(user1) }

    before { expect(message).to receive(:chat).and_return(chat) }

    before do
      expect(UserMailer).to receive(:new_message_email).with(user2, chat) do
        double.tap { |a| expect(a).to receive(:deliver_now) }
      end
    end

    it { expect { subject.before_save(message) }.to_not raise_error }
  end
end
