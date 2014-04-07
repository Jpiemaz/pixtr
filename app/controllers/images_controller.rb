class ImagesController < ApplicationController
  respond_to :html

  def new
    @gallery = current_user.galleries.find(params[:gallery_id])
    @image = Image.new
  end

  def create
    @gallery = current_user.galleries.find(params[:gallery_id])
    @image = @gallery.images.new(image_params)
    @image.save
    respond_with @image, location: @gallery
  end

  def show
    @image = Image.find(params[:id])
    @comment = Comment.new
    @comments = @image.comments.paginated(params[:page])
    @tags = @image.tags
  end

  def edit
    @image = current_user.images.find(params[:id])
    @groups =current_user.groups
  end

  def update
    @image = current_user.images.find(params[:id])
    @image.update(image_params)
    @groups =current_user.groups
    respond_with @image
  end

  def destroy
    image = current_user.images.find(params[:id])
    image.destroy
    redirect_to image.gallery
  end

  private

  def image_params
    params.require(:image).permit(
    :name,
    :description,
    :url,
    :tag_list,
    group_ids: []
    )
  end
end
