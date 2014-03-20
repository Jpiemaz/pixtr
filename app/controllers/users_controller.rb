class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @images = @user.images
    @groups = @user.groups
  end
end
