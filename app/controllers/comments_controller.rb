class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  
  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.create(comment_params)
    if @comment.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, job_id: params[:job_id])
  end
end
