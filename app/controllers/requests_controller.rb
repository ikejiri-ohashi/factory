class RequestsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  # rubocop:disable all
  def create
    requesting = current_user.requests.create(request_id: params[:request_id], job_id: params[:job_id])
    redirect_back(fallback_location: root_path)
  end
  # rubocop:enable all
end
