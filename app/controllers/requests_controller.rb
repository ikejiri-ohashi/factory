class RequestsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  # rubocop:disable all
  def create
    requesting = current_user.requests.create(request_id: params[:request_id], job_id: params[:job_id])
    render json:{ request: requesting }
  end
  # rubocop:enable all
end