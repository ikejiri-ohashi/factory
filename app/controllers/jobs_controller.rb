class JobsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy]
  before_action :set_job, only: [:show, :destroy]
  before_action :move_to_index, only: [:destroy]

  def index
    @jobs = Job.order('created_at DESC')
    @users = User.order('created_at DESC')
    @job_ranks = Job.find(Favorite.group(:job_id).order('count(job_id) desc').limit(3).pluck(:job_id))
    if user_signed_in?
      @company_profile = CompanyProfile.new
      @company_profile = CompanyProfile.find_by(user_id: current_user.id)
      if @company_profile != nil 
        @matched_category = Job.find_by(category_id: @company_profile.category_id)
      end
      # @matched_place = Job.find_by(place_id: @company_profile.place_id)
    end
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
    params.require(:job).permit(:name, :place_id, :deadline_id, :category_id, :sub_category_id, :memo, :job_image,
                                :contact).merge(user_id: current_user.id)
  end

  def set_job
    @job = Job.find(params[:id])
  end

  def move_to_index
    redirect_to action: :index if @job.user_id != current_user.id
  end
end
