class Public::PostCommentsController < ApplicationController

  def create
    @record = Record.find(params[:record_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.record_id = @record.id
    comment.save
  end

  def destroy
    @record = Record.find(params[:record_id])
    PostComment.find_by(id: params[:id], record_id: params[:record_id]).destroy
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end
