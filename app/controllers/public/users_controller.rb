class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_path
    else
      flash[:notice] = "名前、メールアドレスを入力してください"
      render :edit
    end
       
  end

  def quit
  end

  def goodbye
    @user = current_user
    @user.update(is_valid: false)
    reset_session
    flash[:notice] = "退会しました"
    redirect_to root_path
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :image )
  end
  
end
