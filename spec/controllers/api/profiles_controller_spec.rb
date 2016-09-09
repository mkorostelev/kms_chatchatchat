require 'rails_helper'

RSpec.describe Api::ProfilesController, type: :controller do
  it { should route(:get, 'api/profile').to(action: :show) }

  describe '#update.json' do
    # resource.update! resource_params

    # def resource
    #   @user ||= current_user
    # end

    # def resource_params
    #   params.require(:current_user).permit(:first_name, :last_name, :email, :password,
    #                                 :password_confirmation)
    # end

    let(:user) { stub_model User }

    before { sign_in user }

    let(:params) { { current_user: { email: 'one@digits.com', password: '12345678',
                              first_name: 'Name', last_name: 'Surname' } } }

    before { expect(user).to receive(:update!).with(permit!(email: 'one@digits.com', password: '12345678',
                              first_name: 'Name', last_name: 'Surname'))}

    before { patch :update, params: params, format: :json }

    it { expect(response).to have_http_status(:ok) }
  end
end
