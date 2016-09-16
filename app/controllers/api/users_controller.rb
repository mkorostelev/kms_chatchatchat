class Api::UsersController < ApplicationController
  skip_before_action :authenticate, only: [:create]

  def create
    super

    head :created
  end

  private

  def build_resource
    @user = User.new resource_params
  end

  def resource
    @user ||= User.find(params[:id])
  end

  def resource_params
    params.require(:user).permit(:first_name, :last_name, :email, :password,
                                  :password_confirmation)
  end

  def collection
    @collection ||= User.page(params[:page]).per(5)
  end
end
