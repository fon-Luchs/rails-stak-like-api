class ProfilesController < ApplicationController
  skip_before_action :authenticate!, only: :create

  def show
    @user = current_user
    render json: @user, serializer: ProfileSerializer
  end

  private

  def resource
    @user ||= User.new resource_params
  end

  def resource_params
    params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation)
  end

  def resource_response
    render json: resource, serializer: ProfileSerializer
  end
end
