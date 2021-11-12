class UsersController < ApplicationController
  def show
    @user = User.find_by(id: params[:id])
    @jobs = Job.where(user_id: params[:id]).order('created_at DESC')
    @company_profile = CompanyProfile.find_by(user_id: params[:id])
    @check_follow = Follow.find_by(user_id: current_user.id, follow_id: params[:id]) if user_signed_in?
    @check_contract = Contract.all.pluck(:job_id)
    @got_requests = Request.where(request_id: params[:id]).includes(:job)
    @current_user_job = Job.where(user_id: current_user.id).order('created_at DESC') if user_signed_in?
    @jobs_request_sent = Request.where(request_id: params[:id], user_id: current_user.id).includes(:job).order('created_at DESC') if user_signed_in?
    @params_id = params[:id].to_i
  end

  def user_info
    @user = User.find_by(id: params[:id])
    @company_profile = CompanyProfile.find_by(user_id: params[:id])
    @check_follow = Follow.find_by(user_id: current_user.id, follow_id: params[:id]) if user_signed_in?
    @params_id = params[:id].to_i
  end

  def user_follow
    @follows = Follow.where(user_id: params[:id]).includes(:user, :follow).order('created_at DESC')
  end

  def user_follower
    @followers = Follow.where(follow_id: params[:id]).includes(:user, :follow).order('created_at DESC')
  end

  def select_jobs
    @jobs = Job.where(user_id: params[:id]).order('created_at DESC')
    @check_contract = Contract.all.pluck(:job_id)
    @send_requests = Request.where(user_id: params[:id]).pluck(:job_id)
  end

  def select_favorites
    @favorites = Favorite.where(user_id: params[:user_id]).includes(:job).order('created_at DESC')
  end

  def select_contracts
    @contracts = Contract.where(user_id: params[:id]).includes(:job).order('created_at DESC')
  end

  def select_accepts
    @accepts = Contract.where(contracter_id: params[:id]).includes(:job).order('created_at DESC')
  end
end
