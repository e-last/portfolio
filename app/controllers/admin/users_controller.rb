class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  PER =  10

  def index
    @users = User.page(params[:page]).per(PER)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to admin_users_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :is_valid)
  end

end
