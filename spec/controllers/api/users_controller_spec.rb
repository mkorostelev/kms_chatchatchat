require 'rails_helper'

RSpec.describe Api::UsersController, type: :controller do
  it { should route(:get, 'api/users').to(action: :index) }

  it { should route(:post, 'api/users').to(action: :create) }

  describe '#create.json' do
    # def create
    #   build_resource

    #   resource.save!

    #   UserMailer.welcome_email(resource).deliver_now

    #   head :created
    # end

    # private
    # def build_resource
    #   @user = User.new resource_params
    # end

    # def resource
    #   @user ||= params[:id] && params[:action] != 'update' ?
    #                           User.find(params[:id]) : current_user
    # end

    # def resource_params
    #   params.require(:user).permit(:first_name, :last_name, :email, :password,
    #                                 :password_confirmation)
    # end

    let(:params) { { user: { email: 'one@digits.com', password: '12345678',
                              first_name: 'Name', last_name: 'Surname' } } }

    let(:object) { stub_model User }

    before { expect(User).to receive(:new).with(permit!(email: 'one@digits.com', password: '12345678',
                              first_name: 'Name', last_name: 'Surname')).and_return(object)}

    before { expect(object).to receive(:save!) }

    before do
      expect(UserMailer).to receive(:welcome_email).with(object) do
        double.tap { |a| expect(a).to receive(:deliver_now)}
      end
    end

    before { post :create, params: params, format: :json }

    it { expect(response).to have_http_status(:created) }
  end

  describe '#collection' do
    let(:params) { { page: 5 } }

    before { expect(subject).to receive(:params).and_return(params) }

    before do
      expect(User).to receive(:page).with(5) do
        double.tap { |a| expect(a).to receive(:per).with(5) }
      end
    end

    it { expect { subject.send :collection }.to_not raise_error }
  end
end
