class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :set_comment, only: [:destroy]
  before_action :move_to_index, only: [:destroy]

  def create
    comment = Comment.create(comment_params)
    render json:{ comment: comment }
  end

  def destroy
    @comment.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, job_id: params[:job_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def move_to_index
    redirect_to action: :index if @comment.user_id != current_user.id
  end
end
