class PhotoAlbumsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_photo_album, only: %i[show edit update destroy]
  
  def index
    @photo_albums = PhotoAlbum.all
  end

  def show; end

  def new
    @photo_album = PhotoAlbum.new
  end

  def edit; end

  def create
    @photo_album = current_user.photo_albums.new(photo_album_params)

    if @photo_album.save
      redirect_to @photo_album, success: success_message(@photo_album)
    else
      render :new, error: flash_error_message
    end
  end
  
  def update
    if @photo_album.update(photo_album_params)
      redirect_to @photo_album, success: success_message(@photo_album, :updated)
    else
      render :edit, error: flash_error_message
    end
  end
  
  def destroy
    @photo_album.destroy

    redirect_to photo_albums_url, success: success_message(@photo_album, :deleted)
  end

  private

  def set_photo_album
    @photo_album = if user_signed_in?
                     current_user.photo_albums.find(params[:id])
                   else 
                     PhotoAlbum.find(params[:id])
                   end
  end

  def photo_album_params
    params.require(:photo_album).permit(:title)
  end
end