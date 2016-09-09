require 'rails_helper'

RSpec.describe ChatDecorator do
  let(:user) { stub_model User }

  let(:chat) { stub_model Chat, id: 1, name: 'Name' }



  describe '#as_json' do
    context 'collection' do
      subject { chat.decorate(context: { user: user, collection: true }) }

      before { expect(subject).to receive(:unread_messages_count).and_return 1 }

      before { expect(subject).to receive(:last_message).and_return 2 }

      before { expect(subject).to receive(:users).and_return 3 }

      its('as_json.symbolize_keys') do
        should eq \
          id: 1,
          name: 'Name',
          users: 3,
          unread_messages_count: 1,
          last_message: 2
      end
    end

    context 'show' do
      subject { chat.decorate(context: { user: user, show: true }) }

      before { expect(subject).to receive(:unread_messages_count).and_return 1 }

      before { expect(subject).to receive(:messages).and_return 2 }

      before { expect(subject).to receive(:users).and_return 3 }

      its('as_json.symbolize_keys') do
        should eq \
          id: 1,
          name: 'Name',
          users: 3,
          unread_messages_count: 1,
          messages: 2
      end
    end

    context 'other' do
      subject { chat.decorate(context: { user: user }) }

      before { expect(subject).to receive(:unread_messages_count).and_return 1 }

      before { expect(subject).to receive(:users).and_return 3 }

      its('as_json.symbolize_keys') do
        should eq \
          id: 1,
          name: 'Name',
          users: 3,
          unread_messages_count: 1
      end
    end
  end
end
