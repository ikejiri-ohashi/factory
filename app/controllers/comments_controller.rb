class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy]
  
  
  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.create(comment_params)
    if @comment.save
      redirect_to job_path(@comment.job_id)
    else
      render :new
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, job_id: params[:job_id])
  end
end
