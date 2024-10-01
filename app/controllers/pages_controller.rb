class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    skip_authorization
    
    @packages = Package.enabled.order(:position)
    @photo_albums = PhotoAlbum.all
    @about = About.first
    @mission_statement = MissionStatement.first
  end
end
