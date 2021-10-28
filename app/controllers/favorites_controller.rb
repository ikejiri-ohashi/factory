class FavoritesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    favorite = current_user.favorites.create(job_id: params[:job_id])
    @favorites = Favorite.where(job_id: params[:job_id]).pluck(:user_id)
    @job = params[:id]
  end

  def destroy
    @favorite = Favorite.find_by(job_id: params[:job_id], user_id: current_user.id)
    @favorite.destroy
    @favorites = Favorite.where(job_id: params[:job_id]).pluck(:user_id)
    @job = params[:id]
  end
end
