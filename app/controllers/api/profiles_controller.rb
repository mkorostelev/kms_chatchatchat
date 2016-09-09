class Api::ProfilesController < ApplicationController
  private

  def resource
    @user ||= current_user
  end

  def resource_params
    params.require(:current_user).permit(:first_name, :last_name, :email, :password,
                                  :password_confirmation)
  end
end
