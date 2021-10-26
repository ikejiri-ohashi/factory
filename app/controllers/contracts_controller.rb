class ContractsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  # rubocop:disable all
  def create
    ordering = current_user.contracts.create(contracter_id: params[:contracter_id], job_id: params[:job_id])
    render json:{ contract: ordering }
  end
  # rubocop:enable all
end
