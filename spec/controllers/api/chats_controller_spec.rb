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

    let(:user1) { stub_model User }

    let(:user2) { stub_model User }

    before { sign_in user1 }

    let(:params) { { chat: { name: 'chat', user_ids: ['1', '2', '3'] } } }

    let(:resource) { stub_model Chat }

    before { expect(Chat).to receive(:new).with(
        permit!(name: 'chat', user_ids: ['1', '2', '3'])).and_return(resource) }

    before { expect(resource).to receive(:save!) }

    #   resource.users.each do |user|
    #     ApplicationJob.set(wait_until: DateTime.current + 15.seconds)
    #                                    .perform_later(user, resource)
    #   end

    before { expect(resource).to receive(:users).and_return([user1, user2]) }

    before do
      expect(ApplicationJob).to receive(:set)
                            .with(wait_until: DateTime.current + 15.seconds) do
        double.tap do |a|
          expect(a).to receive(:perform_later).with(user1, resource)
        end
      end
    end

    before do
      expect(ApplicationJob).to receive(:set)
                            .with(wait_until: DateTime.current + 15.seconds) do
        double.tap do |a|
          expect(a).to receive(:perform_later).with(user2, resource)
        end
      end
    end

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
end
