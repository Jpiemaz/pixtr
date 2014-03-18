class CommentsController < ApplicationController
  def create
    image = Image.find(params[:image_id])
    comment = image.comments.create(comments_params)
    if comment.save
      redirect_to image, notice: "Commented successfully"
    else
      redirect_to image, notice: "Can not comment with an empty comment"
    end
  end
  
  private
  
  def comments_params
    params.require(:comment).
    permit(:body).
    merge(user_id: current_user.id)
  end
end