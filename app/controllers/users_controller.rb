class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @images = @user.images.includes(:gallery)
    @groups = @user.groups
  end
end
