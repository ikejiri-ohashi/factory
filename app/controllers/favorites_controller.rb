class FavoritesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    favorite = current_user.favorites.create(job_id: params[:job_id])
    render json:{ favorite: favorite }
  end

  def destroy
    @favorite = Favorite.find_by(job_id: params[:job_id], user_id: current_user.id)
    @favorite.destroy
    redirect_back(fallback_location: root_path)
  end
end
