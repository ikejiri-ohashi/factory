class UsersController < ApplicationController
  def show
    @user = User.find_by(id: params[:id])
    @jobs = Job.where(user_id: params[:id])
    @current_user_jobs = Job.where(user_id: current_user.id)
    @request = Request.find_by(request_id: params[:id])
    @company_profile = CompanyProfile.find_by(user_id: params[:id])
    @favorites = Favorite.where(user_id: params[:id]).includes(:job)
    @follows = Follow.where(user_id: params[:id]).includes(:user, :follow)
    @followers = Follow.where(follow_id: params[:id]).includes(:user, :follow)
    @check_follow = Follow.find_by(user_id: current_user.id, follow_id: params[:id]) if user_signed_in?
    @contracts = Contract.where(user_id: params[:id]).includes(:job)
    @accepts = Contract.where(contracter_id: params[:id]).includes(:job)
  end
end
