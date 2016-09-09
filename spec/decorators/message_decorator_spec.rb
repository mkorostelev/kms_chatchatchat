require 'rails_helper'

RSpec.describe MessageDecorator do
  let(:message) { stub_model Message, id: 1, text: 'Text', author: user }

  let(:user) { stub_model User }

  subject { message.decorate(context: { user: user }) }

  describe '#as_json' do
    before { expect(subject).to receive(:message_status).and_return 1 }

    its('as_json.symbolize_keys') do
      should eq \
        text: 'Text',
        id: 1,
        author: user.decorate,
        status: 1
    end
  end
end
