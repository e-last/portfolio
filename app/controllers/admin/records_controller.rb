class Admin::RecordsController < ApplicationController
  before_action :authenticate_admin!
  PER =  10

  def index
    @records = Record.page(params[:page]).per(PER)
  end

  def edit
    @record = Record.find(params[:id])
  end

  def update
    @record = Record.find(params[:id])
    @record.update(record_params)
    redirect_to admin_records_path
  end
  
  def destroy
    @record = Record.find(params[:id])
    @record.destroy
    redirect_to admin_user_path
  end

  private
  def customer_params
    params.require(:user).permit(:name, :email, :is_valid)
  end
  
end
