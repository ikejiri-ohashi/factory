class FavoritesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    favorite = current_user.favorites.create(job_id: params[:job_id])
    @favorites = Favorite.where(job_id: params[:job_id]).pluck(:user_id)
    @job = params[:job_id].to_i
    @count_favorites = Favorite.pluck(:job_id)
    @check_current_user_favorite = Favorite.where(user_id: current_user.id).pluck(:job_id)
  end

  def destroy
    @favorite = Favorite.find_by(job_id: params[:job_id], user_id: current_user.id)
    @favorite.destroy
    @favorites = Favorite.where(job_id: params[:job_id]).pluck(:user_id)
    @job = params[:job_id].to_i
    @count_favorites = Favorite.pluck(:job_id)
    @check_current_user_favorite = Favorite.where(user_id: current_user.id).pluck(:job_id)
  end
end
