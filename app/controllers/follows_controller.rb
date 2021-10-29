class FollowsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    @follow = current_user.follows.create(follow_id: params[:user_id])
    @follow.save
    @followers = Follow.where(follow_id: params[:user_id]).includes(:user, :follow)
    @check_follow = Follow.find_by(user_id: current_user.id, follow_id: params[:id])
  end

  def destroy
    @follow = Follow.find_by(follow_id: params[:user_id], user_id: current_user.id)
    @follow.destroy
    @followers = Follow.where(follow_id: params[:user_id]).includes(:user, :follow)
    @check_follow = Follow.find_by(user_id: current_user.id, follow_id: params[:id])
  end
end