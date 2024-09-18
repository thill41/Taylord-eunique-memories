class PhotosController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[show]
  before_action :set_photo_album
  before_action :set_photo, only: %i[show edit update destroy]
  
  def show
    skip_authorization
    
    @previous_photo = @photo_album.photos.where('id < ?', @photo.id).last
    @next_photo = @photo_album.photos.where('id > ?', @photo.id).first
  end

  def new
    @photo = @photo_album.photos.new
    authorize @photo
  end

  def edit
    authorize @photo
  end

  def create
    @photo = @photo_album.photos.new(photo_params)

    authorize @photo

    @photo.user = current_user

    if @photo.save
      redirect_to photo_album_photo_url(@photo_album, @photo), success: success_message(@photo)
    else
      render :new, error: flash_error_message
    end
  end
  
  def update
    authorize @photo

    if @photo.update(photo_params)
      redirect_to photo_album_photo_url(@photo_album, @photo), success: success_message(@photo, :updated)
    else
      render :edit, error: flash_error_message
    end
  end

  def destroy
    authorize @photo
    
    @photo.destroy

    redirect_to @photo_album, success: success_message(@photo, :deleted)
  end

  private

  def set_photo_album
    @photo_album = PhotoAlbum.find(params[:photo_album_id])
  end

  def set_photo
    @photo = @photo_album.photos.find(params[:id])
  end

  def photo_params
    params.require(:photo).permit(:cover_photo, :description, :image)
  end
end
