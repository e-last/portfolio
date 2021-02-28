class Admin::RecordsController < ApplicationController
  before_action :authenticate_admin!
  PER =  10
  helper_method :sort_column, :sort_direction

  def index
    @records = Record.page(params[:page]).per(PER).order("#{sort_column} #{sort_direction}")
  end

  def edit
    @category_names = Category.pluck("name")
    @record = Record.find(params[:id])
  end
  
  def show
    @record = Record.find(params[:id])
    @post_comment = PostComment.new
  end

  def update
    @record = Record.find(params[:id])
    if @record.update(record_params)
      @record.hour = studyHours(@record.start, @record.end)
      @record.update(record_hour_params)
      redirect_to admin_record_path(@record)
    else
      flash[:notice] = "正しい時刻を入力してください"
      @categories = Category.where(user_id: params[:user_id])
      @category_names = @categories.pluck("name")
      render :edit
    end
  end

  def destroy
    @record = Record.find(params[:id])
    @record.destroy
    redirect_to admin_user_path
  end

  private

  def record_params
    params.require(:record).permit(:name, :color, :start, :end)
  end
  
  def record_hour_params
    params.require(:record).permit(:hour)
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end

  def sort_column
    Record.column_names.include?(params[:sort]) ? params[:sort] : 'id'
  end

  def studyHours( t1, t2 )
    m1 = (t1.to_i / 60).floor
    m2 = (t2.to_i / 60).floor
    diff = m2 - m1
    return diff
  end

end
