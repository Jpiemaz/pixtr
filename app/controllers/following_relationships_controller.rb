class FollowingRelationshipsController < ApplicationController
  def create
    followed_user = find_user
    follow = current_user.follow followed_user
    notify_followers(follow, followed_user, "FollowActivity")
    redirect_to followed_user
  end

  def destroy
    followed_user = find_user
    current_user.unfollow followed_user
    redirect_to followed_user
  end

  private

  def find_user
    User.find(params[:id])
  end
end
