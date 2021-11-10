class RequestsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  # rubocop:disable all
  def create
    requesting = current_user.requests.create(request_id: params[:request_id], job_id: params[:job_id])
    @send_requests = Request.where(job_id: params[:job_id]).includes(:user)
  end

  def create_from_user
    requesting = current_user.requests.create(job_id: params[:job_id], request_id: params[:id])
    @current_user_job = Job.where(user_id: current_user.id)
    @check_contract = Contract.all.pluck(:job_id)
    @jobs_request_sent = Request.where(request_id: params[:id], user_id: current_user.id).includes(:job).order('created_at DESC')
  end
  # rubocop:enable all
end
