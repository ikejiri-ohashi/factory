class CompanyProfilesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  
  def new
    @company_profile = CompanyProfile.new
  end

  def create
    @company_profile = CompanyProfile.new(company_profile_params)
    if @company_profile.save
      redirect_to "https://www.factory-app.com/users/#{@company_profile.user_id}"
      # redirect_to user_url(@company_profile.user_id)
    else
      render :new
    end
  end

  def edit
    @company_profile = CompanyProfile.new
    @company_profile = CompanyProfile.find_by(user_id: params[:id])
  end

  def update
    @company_profile = CompanyProfile.find_by(user_id: params[:id])
    @company_profile.update(company_profile_params)
    if @company_profile.save
      redirect_to "https://www.factory-app.com/users/#{@company_profile.user_id}"
      # redirect_to user_url(@company_profile.user_id)
    else
      render :edit
    end
  end

  private

  def company_profile_params
    params.require(:company_profile).permit(:speciality, :content, :self_introduction, :company_url, :contact).merge(user_id: current_user.id)
  end

end
