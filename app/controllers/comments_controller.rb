class CommentsController < ApplicationController
  def create
    @image = Image.find(params[:image_id])
    @comment = @image.comments.new(comments_params)
    if @comment.save
      current_user.notify_followers(@comment, @image, "CommentActivity")
    else
      redirect_to @image, notice: "Can not comment with an empty comment"
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
  end
  private

  def comments_params
    params.require(:comment).
    permit(:body).
    merge(user_id: current_user.id)
  end
end
