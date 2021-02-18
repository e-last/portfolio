class Public::RecordsController < ApplicationController

  before_action :set_user

  def create
    @category = Category.find(params[:category_id])
    @record = Record.new(user_id: @user.id, name: @category.name, color: @category.color, start: DateTime.current, category_id: @category.id)
    @record.save
    redirect_to record_path(@record)
  end

  def finish
    @record = Record.find(params[:id])
    @record.end = Time.now
    @record.save
    redirect_to records_path(@record)
  end

  def index
    @records = Record.where(user_id: @user.id)
  end

  def show
    @record = Record.find(params[:id])
    @post_comment = PostComment.new
  end

  def edit
     @record = Record.find(params[:id])
  end

  def update
    @record = Record.find(params[:id])
    @record.update(record_update_params)
    redirect_to record_path(@record)
  end

  def destroy
    record = Record.find(params[:id])
    record.destroy
    redirect_to records_path
  end

  private

  def set_user
    @user = current_user
  end

  def record_update_params
    params.require(:record).permit(:name, :color, :start, :end)
  end

  def record_finish_params
    params.require(:record).permit(:end)
  end

end
