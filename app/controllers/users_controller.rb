class UsersController < ApplicationController

  def show
    @user = User.find_by(id: params[:id])
    @jobs = Job.where(user_id: params[:id])
    @company_profile = CompanyProfile.find_by(user_id: params[:id])
    if @company_profile.nil?
      @company_profile = CompanyProfile.new
    end
    @favorites = Favorite.where(user_id: params[:id])
    @follows = Follow.where(user_id: params[:id])
    @followers = Follow.where(follow_id: params[:id])
    if user_signed_in?
      @check_follow = Follow.find_by( user_id: current_user.id ,follow_id: params[:id])
    end
  end

end
