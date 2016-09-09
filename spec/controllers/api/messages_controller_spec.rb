require 'rails_helper'

RSpec.describe Api::MessagesController, type: :controller do
  # it { should route(:get, 'api/chats/1/messages').to be_routable }

  # it { should route(:post, 'api/chats/1/messages').to be_routable}

  # it { should route(:get, 'api/chats/1/messages/1').to be_routable }

  describe '#create.json' do
    # def create
    #   build_resource

    #   resource.save!
    # end

    # def parent
    #   @parent ||= Chat.find(params[:chat_id])
    # end

    # def build_resource
    #   @message = parent.messages.new resource_params
    # end

    # def resource
    #   @message ||= Message.find(params[:id])
    # end

    # def resource_params
    #   params.require(:message).permit(:text).merge(author: current_user)
    # end

    let(:params) { { chat_id: '1', message: { text: '1' } } }

    let(:object) { stub_model Message }

    let(:parent) { stub_model Chat }

    before { expect(Chat).to receive(:find).with('1').and_return(parent) }

    let(:user) { stub_model User }

    before { sign_in user }

    before do
      expect(parent).to receive(:messages) do
        double.tap { |a| expect(a).to receive(:new).with(permit!(text: '1', author: user))
                                                  .and_return(object) }
      end
    end

    before { expect(object).to receive(:save!) }

    before { post :create, params: params, format: :json }

    it { expect(response).to have_http_status(:ok) }
  end
end
