class CommentsController < ApplicationController
  def create
    image = Image.find(params[:image_id])
    image.comments.create(comments_params)
    redirect_to image
  end
  
  private
  
  def comments_params
    params.require(:comment).
    permit(:body).
    merge(user_id: current_user.id)
  end
end