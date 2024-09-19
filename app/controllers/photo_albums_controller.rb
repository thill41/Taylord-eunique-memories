class PhotoAlbumsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_photo_album, only: %i[show edit update destroy]
  
  def index
    @photo_albums = PhotoAlbum.all.paginate(page: params[:page], per_page: 10)
  end

  def show
    @photos = @photo_album.photos
  end

  def new
    @photo_album = PhotoAlbum.new
    
    authorize @photo_album
  end

  def edit
    authorize @photo_album
  end

  def create
    @photo_album = current_user.photo_albums.new(photo_album_params)
    
    authorize @photo_album

    if @photo_album.save
      redirect_to @photo_album, success: success_message(@photo_album)
    else
      render :new, error: flash_error_message
    end
  end
  
  def update
    authorize @photo_album

    if @photo_album.update(photo_album_params)
      redirect_to @photo_album, success: success_message(@photo_album, :updated)
    else
      render :edit, error: flash_error_message
    end
  end
  
  def destroy
    authorize @photo_album

    @photo_album.destroy

    redirect_to photo_albums_url, success: success_message(@photo_album, :deleted)
  end

  private

  def set_photo_album
    @photo_album = if user_signed_in?
                     current_user.photo_albums.includes(:photos).find(params[:id])
                   else 
                     PhotoAlbum.includes(:photos).find(params[:id])
                   end
  end

  def photo_album_params
    params.require(:photo_album).permit(:title)
  end
end
