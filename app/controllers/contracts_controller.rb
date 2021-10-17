class ContractsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    ordering = current_user.contracts.create(contracter_id: 2, job_id: params[:job_id])
    redirect_back(fallback_location: root_path)
  end

end
