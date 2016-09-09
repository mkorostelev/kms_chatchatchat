require 'rails_helper'

RSpec.describe Api::MarkAsReadedsController, type: :controller do
  describe '#show' do
    # Chat.find(params[:chat_id]).users_messages.where(user: current_user)
    #                                           .update_all(status: 1)
    # head:ok

    let(:user) { stub_model User }

    before { sign_in user }

    let(:params) { { chat_id: '1' } }

    # before { expect(subject).to receive(:params).and_return(params) }

    before do
      expect(Chat).to receive(:find).with('1') do
        double.tap do |a|
          expect(a).to receive(:users_messages) do
            double.tap do |b|
              expect(b).to receive(:where).with(user: user) do
                double.tap { |c| expect(c).to receive(:update_all).with(status: 1) }
              end
            end
          end
        end
      end
    end

    before { get :show, params: params, format: :json }

    it { expect(response).to have_http_status(:ok) }
  end
end
