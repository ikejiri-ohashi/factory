class JobsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy]
  before_action :set_job, only: [:show, :destroy]
  before_action :move_to_index, only: [:destroy]

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
      redirect_to root_url
      # redirect_to "https://www.factory-app.com/jobs/#{@job.id}"
    else
      render :new
    end
  end

  def show
    @comment = @job.comments.includes(:user)
  end

  def destroy
    @job.destroy
    redirect_to root_url
    # redirect_to "https://www.factory-app.com/"
  end

  private

  def job_params
    params.require(:job).permit(:name, :place, :deadline, :category_id, :memo, :contact).merge(user_id: current_user.id)
  end

  def set_job
    @job = Job.find(params[:id])
  end

  def move_to_index
    redirect_to action: :index if @job.user_id != current_user.id
  end

end
