class CompanyProfilesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_company_profile, only: [:edit, :update]
  before_action :move_to_index, only: [:edit, :update]

  def new
    @company_profile = CompanyProfile.new
    @params_id = params[:user_id].to_i
  end

  def create
    @company_profile = CompanyProfile.new(company_profile_params)
    @company_profile.save
    @params_id = params[:user_id].to_i
  end

  def edit
    @params_id = params[:user_id].to_i
  end

  def update
    @company_profile.update(company_profile_params)
    @company_profile.save
    @params_id = params[:user_id].to_i
  end

  def show
    @company_profile = CompanyProfile.find_by(user_id: params[:id])
    @params_id = params[:user_id].to_i
  end

  private

  def company_profile_params
    params.require(:company_profile).permit(:category_id, :content, :self_introduction, :place_id, :company_url,
                                            :contact).merge(user_id: current_user.id)
  end

  def set_company_profile
    @company_profile = CompanyProfile.find_by(user_id: params[:id])
  end

  def move_to_index
    redirect_to root_path if @company_profile.user_id != current_user.id
  end
end
