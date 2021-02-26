class Public::CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def index
    @categories = Category.where(user_id: @user.id)
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    @category.user_id = @user.id
    if @category.save
      redirect_to categories_path
    else
      flash[:notice] = "カテゴリー名を入力してください"
      @categories = Category.where(user_id: @user.id)
      render :index
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    category = Category.find(params[:id])
    if category.update(category_params)
      redirect_to categories_path
    else
      flash[:notice] = "カテゴリー名を入力してください"
      @category = Category.find(params[:id])
      render :edit
    end
  end

  def destroy
    category = Category.find(params[:id])
    category.destroy
    redirect_to categories_path
  end

  def time
    @category = Category.find(params[:id])
  end

  private

  def set_user
    @user = current_user
  end

  def category_params
  params.require(:category).permit(:name, :color)
  end

end
