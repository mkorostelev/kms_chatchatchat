require 'rails_helper'

RSpec.describe UserDecorator do
  let(:user) { stub_model User, id: 1, first_name: 'Name', last_name: 'Surname', email: 'test@test.com' }

  subject { user.decorate(context: { user: user }) }

  describe '#as_json' do
    # def unreaded_chats_count
    #   Chat.joins(:users_messages).where(users_messages:
    #                        { status: 0, user: context[:user] }).distinct.count
    # end

    before do
      expect(Chat).to receive(:joins).with(:users_messages) do
        double.tap do |a|
          expect(a).to receive(:where).with(users_messages: { status: 0, user: user }) do
            double.tap do |b|
              expect(b).to receive(:distinct) do
                double.tap do |c|
                  expect(c).to receive(:count).and_return(1)
                end
              end
            end
          end
        end
      end
    end

    its('as_json.symbolize_keys') do
      should eq \
        id: 1,
        full_name: 'Name Surname',
        email: 'test@test.com',
        unreaded_chats_count: 1
    end
  end
end
