class CompanyProfilesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_company_profile, only: [:edit, :update]
  before_action :move_to_index, only: [:edit, :update]

  def new
    @check_profile = CompanyProfile.find_by(user_id: current_user.id)
    if @check_profile.nil?
      @company_profile = CompanyProfile.new
    else
      redirect_to root_path
    end
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
  end

  def update
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
    params.require(:company_profile).permit(:category_id, :sub_category_id, :content, :self_introduction, :place_id, :company_url,
                                            :contact).merge(user_id: current_user.id)
  end

  def set_company_profile
    @company_profile = CompanyProfile.find_by(user_id: params[:id])
  end

  def move_to_index
    redirect_to root_path if @company_profile.user_id != current_user.id
  end
end
