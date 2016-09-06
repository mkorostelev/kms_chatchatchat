require 'rails_helper'

RSpec.describe Api::ChatsController, type: :controller do
  it { should route(:get, 'api/chats').to(action: :index) }

  it { should route(:post, 'api/chats').to(action: :create) }

  it { should route(:get, 'api/chats/1').to(action: :show, id: 1) }

  describe '#create.json' do
    # def create
    #   build_resource

    #   resource.save!
    # end

    # private

    # def build_resource
    #   @chat = Chat.new resource_params
    # end

    # def resource
    #   @chat ||= Chat.find(params[:id])
    # end

    # def resource_params
    #   params.require(:chat).permit(:name, user_ids: [])
    # end

    let(:user) { stub_model User }

    before { sign_in user }

    let(:params) { { chat: { name: 'chat', user_ids: ['1', '2', '3'] } } }

    let(:object) { stub_model Chat }

    before { expect(Chat).to receive(:new).with(
        permit!(name: 'chat', user_ids: ['1', '2', '3'])).and_return(object) }

    before { expect(object).to receive(:save!) }

    before { post :create, params: params, format: :json }

    it { expect(response).to have_http_status(:ok) }
  end

  describe '#collection' do
    let(:params) { { page: 5 } }

    before { expect(subject).to receive(:params).and_return(params) }

    before do
      expect(Chat).to receive(:page).with(5) do
        double.tap { |a| expect(a).to receive(:per).with(5) }
      end
    end

    it { expect { subject.send :collection }.to_not raise_error }
  end

  describe '#mark_as_readed' do
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

    before { get :mark_as_readed, params: params, format: :json }

    #!!! it { expect(response).to have_http_status(:ok) }
  end
end
