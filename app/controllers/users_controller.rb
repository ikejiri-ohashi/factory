class UsersController < ApplicationController
  def show
    @user = User.find_by(id: params[:id])
    @jobs = Job.where(user_id: params[:id])
    @company_profile = CompanyProfile.find_by(user_id: params[:id])
    
    @follows = Follow.where(user_id: params[:id]).includes(:user, :follow)
    @followers = Follow.where(follow_id: params[:id]).includes(:user, :follow)
    @check_follow = Follow.find_by(user_id: current_user.id, follow_id: params[:id]) if user_signed_in?
    @contracts = Contract.where(user_id: params[:id]).includes(:job)
    @check_contract = Contract.all.pluck(:job_id)
    @accepts = Contract.where(contracter_id: params[:id]).includes(:job)
    @got_requests = Request.where(request_id: params[:id]).includes(:job)
    @send_requests = Request.where(user_id: params[:id]).pluck(:job_id)
    @current_user_job = Job.where(user_id: current_user.id) if user_signed_in?
  end

  def select_jobs
  end
  def select_favorites
    @favorites = Favorite.where(user_id: params[:user_id]).includes(:job)
  end
  def select_contracts
  end
  def select_accepts
  end
end
