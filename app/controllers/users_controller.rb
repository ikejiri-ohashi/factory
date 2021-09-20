class UsersController < ApplicationController

  def show
    @user = User.find_by(id: params[:id])
    @company_profile = CompanyProfile.find_by(user_id: params[:id])
    if user_signed_in?
      @follow = Follow.find_by(follow_id: params[:id], user_id: current_user.id)
    end
    @follows = Follow.where(user_id: params[:id])
    @followers = Follow.where(follow_id: params[:id])
  end

end
