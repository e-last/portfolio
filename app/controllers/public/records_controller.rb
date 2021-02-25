class Public::RecordsController < ApplicationController
  before_action :set_user
  range = Date.yesterday.beginning_of_day..Date.yesterday.end_of_day
  PER =  10
  helper_method :sort_column, :sort_direction

  def new
    @record = Record.new
    @category_names = Category.pluck("name")
  end

  def add
    record = Record.new(record_params)
    record.user_id = current_user.id
    record.hour = studyHours( record.start, record.end )
    record.save
    redirect_to records_path
  end

  def create
    @category = Category.find(params[:category_id])
    @record = Record.new(user_id: @user.id, name: @category.name, color: @category.color, start: DateTime.current, category_id: @category.id)
    @record.save
    redirect_to record_path(@record)
  end

  def finish
    @record = Record.find(params[:id])
    @record.end = Time.now
    @record.hour = studyHours(@record.start, @record.end)
    @record.save
    redirect_to records_path(@record)
  end

  def index
    @records = Record.page(params[:page]).per(PER).order("#{sort_column} #{sort_direction}")
  end

  def show
    @record = Record.find(params[:id])
    @post_comment = PostComment.new
  end

  def edit
    @category_names = Category.pluck("name")
    @record = Record.find(params[:id])
  end

  def update
    @record = Record.find(params[:id])
    @record.update(record_params)
    @record.hour = studyHours(@record.start, @record.end)
    @record.update(record_hour_params)
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

  def yesterdayHours(user)
    yesterdayRecords = user.record.where(start == now.yesterday)
    sum = 0
    yesterdayRecords.each do |yesterdayRecord|
      sum += yesterdayRecord.hour
    end
    return minute(sum)
  end

end
