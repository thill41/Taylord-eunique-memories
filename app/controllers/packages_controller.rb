class PackagesController < ApplicationController
  before_action :set_package, only: %i[show edit update destroy]

  def index
    skip_authorization
    @packages = Package.enabled.order(:position)
  end

  def show; end
  
  def new
    @package = Package.new
  end
  
  def edit; end

  def create
    @package = Package.new(package_params)
    @package.user = current_user

    if @package.save
      redirect_to @package, success: success_message(@package)
    else
      flash_error_message
      render :new
    end
  end

  def update
    if @package.update(package_params)
      redirect_to @package, success: success_message(@package, :updated)
    else
      flash_error_message
      render :edit
    end
  end

  def destroy
    @package.destroy

    redirect_to packages_url, success: success_message(@package, :deleted)
  end
  
  private

  def set_package
    @package = Package.find(params[:id])
  end

  def package_params
    params.require(:package).permit(:name, :statement, :price, :position, :description, :enabled, :frequency)
  end
end
