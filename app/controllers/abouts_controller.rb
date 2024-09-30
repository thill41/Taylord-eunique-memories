class AboutsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  before_action :set_about, only: %i[show edit update]
  
  def show
    authorize @about
  end

  def edit
    authorize @about
  end

  def update
    authorize @about
    
    if @about.update(about_params)
      redirect_to about_path, success: success_message(@about)
    else
      flash_error_message
      render :edit
    end
  end

  private

  def set_about
    @about = About.first_or_create!(content: 'About Us')
  end

  def about_params
    params.require(:about).permit(:content, :user)
  end
end
