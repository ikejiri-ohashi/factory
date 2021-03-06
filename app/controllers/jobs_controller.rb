class JobsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy]
  before_action :set_job, only: [:show, :destroy]
  before_action :move_to_index, only: [:destroy]

  def index
    @jobs = Job.order('created_at DESC').includes(:user)
    @contracts = Contract.pluck(:job_id)
    @view_contracts = Contract.order('created_at DESC').includes(:job).limit(10)
    @count_favorites = Favorite.pluck(:job_id)
    @job_ranks = Job.find(Favorite.group(:job_id).order('count(job_id) desc').limit(3).pluck(:job_id))
    return unless user_signed_in?

    @login_user = User.find(current_user.id)
    @check_current_user_favorite = Favorite.where(user_id: current_user.id).pluck(:job_id)
    @company_profile = CompanyProfile.new
    @company_profile = CompanyProfile.find_by(user_id: current_user.id)
    @user_posted_jobs = Job.order('created_at DESC').where(user_id: current_user.id)
    @check_requests = Request.where(request_id: current_user.id)
    @check_contracts = Contract.pluck(:job_id)
    @login_user_jobs = Job.where(user_id: current_user.id).order('created_at DESC').limit(3)

    return if @company_profile.nil?

    @job_recommends = Job.where(category_id: @company_profile.category_id, place_id: @company_profile.place_id)
  end

  def back_index
    @jobs = Job.order('created_at DESC').includes(:user)
    @contracts = Contract.pluck(:job_id)
    @count_favorites = Favorite.pluck(:job_id)
    @category_params = params[:category_id].to_i
    @place_params = params[:place_id].to_i
    if @category_params.in?([ 0, 1 ])
      @category_params = nil
    end
    if @place_params.in?([ 0, 1 ])
      @place_params = nil
    end

    if @category_params.present? && @place_params.present?
      @research_jobs = Job.where(category_id: @category_params, place_id: @place_params).order('created_at DESC')
    elsif @category_params.present?
      @research_jobs = Job.where(category_id: @category_params).order('created_at DESC')
    elsif @place_params.present?
      @research_jobs = Job.where(place_id: @place_params).order('created_at DESC')
    else
      @research_jobs = @jobs
    end

    return unless user_signed_in?

    @check_current_user_favorite = Favorite.where(user_id: current_user.id).pluck(:job_id)
    @company_profile = CompanyProfile.find_by(user_id: current_user.id)
    @user_posted_jobs = Job.order('created_at DESC').where(user_id: current_user.id)

    return if @company_profile.nil?

    @job_recommends = Job.where(category_id: @company_profile.category_id, place_id: @company_profile.place_id)
    @match_place_jobs = Job.where(place_id: @company_profile.place_id)
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
    @send_requests = Request.where(user_id: current_user.id) if user_signed_in?
    @recommend_user = CompanyProfile.where(category_id: @selected_job.category_id,
                                           place_id: @selected_job.place_id).includes(:user)
  end

  def user_research
    @users_profile = CompanyProfile.order('created_at DESC').includes(:user)
    @users = User.order('created_at DESC')
    @category_params = params[:category_id].to_i
    @place_params = params[:place_id].to_i
    if @category_params.in?([ 0, 1 ])
      @category_params = nil
    end
    if @place_params.in?([ 0, 1 ])
      @place_params = nil
    end

    if @category_params.present? && @place_params.present?
      @research_profiles = CompanyProfile.where(category_id: @category_params, place_id: @place_params).order('created_at DESC').includes(:user)
    elsif @category_params.present?
      @research_profiles = CompanyProfile.where(category_id: @category_params).order('created_at DESC').includes(:user)
    elsif @place_params.present?
      @research_profiles = CompanyProfile.where(place_id: @place_params).order('created_at DESC').includes(:user)
    else
      @research_profiles = @jobs
    end
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
    @comment = Comment.new
    @comments = @job.comments.includes(:user).order('created_at DESC')
    @contract = Contract.find_by(job_id: params[:id])
    @users = User.order('created_at DESC')
    @count_favorites = Favorite.pluck(:job_id)
    @request = Request.new
    @send_requests = Request.where(job_id: params[:id]).includes(:user)
    @params_id = params[:id].to_i

    return unless user_signed_in?

    @check_request = Request.find_by(job_id: params[:id], request_id: current_user.id)
    @check_current_user_favorite = Favorite.where(user_id: current_user.id).pluck(:job_id)
    @user_profile = CompanyProfile.find_by(user_id: current_user.id)
  end

  def edit
    @job = Job.find_by(id: params[:id])
  end

  def back_info
    @job = Job.find_by(id: params[:job_id])
    @params_id = params[:job_id].to_i
    @contract = Contract.find_by(job_id: params[:job_id])
  end

  def update
    @job = Job.find_by(id: params[:id])
    @job.update(job_params)
    @job.save
    @params_id = params[:id].to_i
  end

  def destroy
    @job.destroy
    # redirect_to root_url
    redirect_to "https://www.factory-app.com/"
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
