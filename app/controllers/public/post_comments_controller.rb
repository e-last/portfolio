class Public::PostCommentsController < ApplicationController
  
  def create
    record = Record.find(params[:record_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.record_id = record.id
    comment.save
    redirect_to record_path(record)
  end

  def destroy
    PostComment.find_by(id: params[:id], record_id: params[:record_id]).destroy
    redirect_to record_path(params[:record_id])
  end
  
  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
  
end
