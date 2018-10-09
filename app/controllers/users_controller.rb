class UsersController < ApplicationController
  def index
    @users = User.all.order('reputation DESC')
    render json: @users, serializer: UserIndexSerializer
  end

  def show
    @user = User.find(params[:id])
    render json: @user, serializer: UserShowSerializer
  end
end
