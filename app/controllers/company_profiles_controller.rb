class CompanyProfilesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  
  def new
    @company_profile = CompanyProfile.new
  end

  def create
    @company_profile = CompanyProfile.new(company_profile_params)
    if @company_profile.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def company_profile_params
    params.require(:company_profile).permit(:speciality, :content, :self_introduction, :conmapy_url, :contact).merge(user_id: current_user.id)
  end

end
