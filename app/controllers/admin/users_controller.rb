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
      @User.update(user_params)
      redirect_to admin_user_path
  end

  private
  def customer_params
      params.require(:user).permit(:name, :email, :is_valid)
  end
    
end
