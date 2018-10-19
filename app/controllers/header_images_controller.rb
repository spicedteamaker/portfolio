class HeaderImagesController < ApplicationController
  before_action :check_privilege, only: [:new, :create]
  def new
    @headerImage = HeaderImage.new
  end

  def create
    @headerImage = HeaderImage.create(header_image_params)
    if @headerImage.valid?
      image = HeaderImage.first
      image.destroy
      redirect_to posts_path
    elsif !@headerImage.valid?
      render header_images_new_path
    end
  end

  def header_image_params
    params.require(:header_image).permit(:title, :picture)
  end
end
