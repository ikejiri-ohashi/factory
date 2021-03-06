class ContractsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  # rubocop:disable all
  def create
    ordering = current_user.contracts.create(contracter_id: params[:contracter_id], job_id: params[:job_id])
    redirect_back(fallback_location: root_path)
  end
  # rubocop:enable all
end
