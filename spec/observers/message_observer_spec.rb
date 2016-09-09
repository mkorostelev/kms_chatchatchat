# require 'rails_helper'

# RSpec.describe MessageObserver, type: :observer do
#   let(:user1) { stub_model User }

#   let(:user2) { stub_model User }

#   let(:chat) { stub_model Chat, user_ids: [user1.id, user2.id] }

#   let(:message) { stub_model Message, text: 'text', author: user1 }

#   subject { described_class.send(:new) }

#   describe '#before_save' do
#     # message.chat.users.each do |user|
#     #   users_message = message.users_messages.build(user: user)
#     #   users_message.status = :readed if user == message.author
#     # end

#     let(:message) { stub_model Message }

#     let(:user) { stub_model User }

#     before do
#       expect(message).to receive(:chat) do
#         double.tap do |a|
#           expect(a).to receive(:users) do
#             double.tap { |b| expect(b).to receive(:each).and_return(user) }
#           end
#         end
#       end
#     end

#     before do
#       expect(message).to receive(:users_messages) do
#         double.tap do |a|
#           expect(a).to receive(:build).with(user: user)
#         end
#       end
#     end

#     it { expect { subject.before_save(message) }.to_not raise_error }
#   end
# end
