class RequestsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  # rubocop:disable all
  def create
    if request_id == params[:id]
      ordering = current_user.contracts.create(request_id: params[:id], job_id: params[:job_id])
      redirect_back(fallback_location: root_path)
    else
      ordering = current_user.contracts.create(request_id: params[:request_id], job_id: params[:id])
      redirect_back(fallback_location: root_path)
    end
  end
  # rubocop:enable all
end
