class JobsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy]
  before_action :set_job, only: [:show, :destroy]
  before_action :move_to_index, only: [:destroy]

  def index
    @jobs = Job.order('created_at DESC')
    @users = User.order('created_at DESC')
    @contracts = Contract.pluck(:job_id)
    @favorites = Favorite.pluck(:job_id)
    @job_ranks = Job.find(Favorite.group(:job_id).order('count(job_id) desc').limit(3).pluck(:job_id))
    return unless user_signed_in?

    @company_profile = CompanyProfile.new
    @company_profile = CompanyProfile.find_by(user_id: current_user.id)
    @user_posted_job = Job.find_by(user_id: current_user.id)

    unless @company_profile.nil?
      @job_recommends = Job.where(category_id: @company_profile.category_id, place_id: @company_profile.place_id)
    end

    unless @user_posted_job.nil?
      @recommend_user = User.find(CompanyProfile.where(category_id: @user_posted_job.category_id, place_id: @user_posted_job.place_id).pluck(:user_id))
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
    @comment = @job.comments.includes(:user).order('created_at DESC')
    @contract = Contract.find_by(job_id: params[:id])
    @users = User.order('created_at DESC')
    @favorites = Favorite.where(job_id: params[:id])
  end

  def destroy
    @job.destroy
    redirect_to root_url
    # redirect_to "https://www.factory-app.com/"
  end

  private

  def job_params
    params.require(:job).permit(:name, :place_id, :deadline_id, :category_id, :memo, :job_image,
                                :contact).merge(user_id: current_user.id)
  end

  def set_job
    @job = Job.find(params[:id])
  end

  def move_to_index
    redirect_to action: :index if @job.user_id != current_user.id
  end
end
