class Public::PostCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @record = Record.find(params[:record_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.record_id = @record.id
    if comment.save
    else
      flash[:notice] = "コメントを入力してください"
      render :"public/records/show"
    end
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
