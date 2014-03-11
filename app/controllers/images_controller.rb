class ImagesController < ApplicationController
  def new
    @image = Image.new
    @gallery = Gallery.find(params[:gallery_id])
  end
  def create
    gallery = Gallery.find(params[:gallery_id])
    image = gallery.images.create(image_params)
    redirect_to gallery
  end
  def destroy
    image = Image.find(params[:id])
    image.destroy
    redirect_to gallery
  end
  private
  
  def image_params
    params.require(:image).permit(:name, :description, :url)
  end
end