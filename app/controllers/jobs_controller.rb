class JobsController < ApplicationController

  def index
    @jobs = Job.all
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

  private

  def job_params
    params.require(:job).permit(:name, :place, :deadline, :category_id, :memo, :contact).merge(user_id: current_user.id)
  end

end
