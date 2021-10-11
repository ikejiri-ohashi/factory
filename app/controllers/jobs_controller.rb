class JobsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy]

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
      # redirect_to root_url
      redirect_to "https://www.factory-app.com/jobs/#{@job.id}"
    else
      render :new
    end
  end

  def show
    @job = Job.find(params[:id])
    @comment = @job.comments.includes(:user)
  end

  def destroy
    @job = Job.find(params[:id])
    @job.destroy
    # redirect_to root_url
    redirect_to "https://www.factory-app.com/"
  end

  private

  def job_params
    params.require(:job).permit(:name, :place, :deadline, :category_id, :memo, :contact).merge(user_id: current_user.id)
  end

end
