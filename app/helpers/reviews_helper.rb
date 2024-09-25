module ReviewsHelper
  def reviewer_name(review)
    if review.first_name.present? && review.last_name.present?
      "#{review.first_name} #{review.last_name}"
    elsif review.first_name.present?
      review.first_name
    elsif review.last_name.present?
      reivew.last_name
    else
      'Anonymous'
    end
  end
end
