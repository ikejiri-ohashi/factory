class ContractsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    ordering = current_user.contracts.create(contracter_id: 2, job_id: params[:job_id])
    if ordering.save
      flash[:success] = '契約済みとして登録しました'
      redirect_to root_path
    else
      flash.now[:alert] = '登録に失敗しました'
      redirect_to root_path
    end
  end

end
