class FollowsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    @follow = current_user.follows.create(follow_id: params[:user_id])
    @follow.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @follow = Follow.find_by(follow_id: params[:id], user_id: current_user.id)
    @follow.destroy
    redirect_back(fallback_location: root_path)
  end
end
