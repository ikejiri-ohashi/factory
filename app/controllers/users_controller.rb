class UsersController < ApplicationController
  def show
    @user = User.find_by(id: params[:id])
    @company_profile = CompanyProfile.find_by(user_id: params[:id])
  end
end
