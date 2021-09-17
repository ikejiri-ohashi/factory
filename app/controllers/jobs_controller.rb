class JobsController < ApplicationController

  def index
    @jobs = Job.order('created_at DESC')
    @users = User.order('created_at DESC')
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)
    if @job.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @job = Job.find(params[:id])
    @comment = @job.comments.includes(:user)
  end

  private

  def job_params
    params.require(:job).permit(:name, :place, :deadline, :category_id, :memo, :contact).merge(user_id: current_user.id)
  end

end
