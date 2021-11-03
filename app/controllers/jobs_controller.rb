class JobsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy]
  before_action :set_job, only: [:show, :destroy]
  before_action :move_to_index, only: [:destroy]

  def index
    @jobs = Job.order('created_at DESC').includes(:user)
    @contracts = Contract.pluck(:job_id)
    @count_favorites = Favorite.pluck(:job_id)
    @job_ranks = Job.find(Favorite.group(:job_id).order('count(job_id) desc').limit(3).pluck(:job_id))
    return unless user_signed_in?

    @login_user = User.find(current_user.id)
    @check_current_user_favorite = Favorite.where(user_id: current_user.id).pluck(:job_id)
    @company_profile = CompanyProfile.new
    @company_profile = CompanyProfile.find_by(user_id: current_user.id)
    @user_posted_jobs = Job.order('created_at DESC').where(user_id: current_user.id)

    unless @company_profile.nil?
      @job_recommends = Job.where(category_id: @company_profile.category_id, place_id: @company_profile.place_id)
    end
  end

  def back_index
    @jobs = Job.order('created_at DESC').includes(:user)
    @contracts = Contract.pluck(:job_id)
    @count_favorites = Favorite.pluck(:job_id)

    return unless user_signed_in?

    @check_current_user_favorite = Favorite.where(user_id: current_user.id).pluck(:job_id)
    @company_profile = CompanyProfile.find_by(user_id: current_user.id)
    @user_posted_jobs = Job.order('created_at DESC').where(user_id: current_user.id)

    unless @company_profile.nil?
      @job_recommends = Job.where(category_id: @company_profile.category_id, place_id: @company_profile.place_id)
    end
  end

  def pre_recommend
    @users_profile = CompanyProfile.order('created_at DESC').includes(:user)
    @users = User.order('created_at DESC')
    @contracts = Contract.pluck(:job_id)
    
    return unless user_signed_in?

    @user_posted_jobs = Job.order('created_at DESC').where(user_id: current_user.id)
  end

  def recommend
    @users_profile = CompanyProfile.order('created_at DESC').includes(:user)
    @users = User.order('created_at DESC')
    @contracts = Contract.pluck(:job_id)
    @user_posted_jobs = Job.order('created_at DESC').where(user_id: current_user.id)
    @selected_job = Job.find(params[:id])
    @recommend_user = CompanyProfile.where(category_id: @selected_job.category_id,
                                           place_id: @selected_job.place_id).includes(:user)
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
    @comment = Comment.new
    @comments = @job.comments.includes(:user).order('created_at DESC')
    @contract = Contract.find_by(job_id: params[:id])
    @users = User.order('created_at DESC')
    @count_favorites = Favorite.pluck(:job_id)
    @request = Request.new
    @send_requests = Request.where(job_id: params[:id]).includes(:user)

    return unless user_signed_in?

    @check_request = Request.find_by(job_id: params[:id], request_id: current_user.id)
    @check_current_user_favorite = Favorite.where(user_id: current_user.id).pluck(:job_id)
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
