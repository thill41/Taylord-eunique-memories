class ReviewsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index new create]
  def index
    @reviews = Review.all.reverse
  end

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)

    if @review.save
      redirect_to reviews_path, success: success_message(@review)
    else
      flash_error_message
      render :new
    end
  end

  def destroy
    @review = Review.find(params[:id])

    authorize @review

    @review.destroy

    redirect_to reviews_path, success: success_message(@review, :destroyed)
  end

  private

  def review_params
    params.require(:review).permit(:rating, :content, :first_name, :last_name, :email)
  end
end
