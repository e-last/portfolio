class Admin::PostCommnetsController < ApplicationController

  def destroy
    @record = Record.find(params[:record_id])
    PostComment.find_by(id: params[:id], record_id: params[:record_id]).destroy
  end

end
