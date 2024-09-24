class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @packages = Package.enabled.order(:position)
    @photo_albums = PhotoAlbum.all
  end
end
