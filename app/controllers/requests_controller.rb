class RequestsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  # rubocop:disable all
  def create
    requesting = current_user.requests.create(request_id: params[:request_id], job_id: params[:job_id])
    @send_requests = Request.where(job_id: params[:id]).includes(:user)
  end
  # rubocop:enable all
end