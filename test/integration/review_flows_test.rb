require 'test_helper'

class ReviewFlowsTest < BaseIntegrationTest
  test 'requires authentication' do
    requires_authentication { delete review_path(create(:review)) }
  end

  test 'can create a new review' do
    get new_review_url
    assert_response :success

    assert_difference('Review.count', 1) do
      post reviews_path, params: { review: attributes_for(:review) }
    end

    assert_redirected_to reviews_path
    follow_redirect!
    assert_flash :success
  end

  test 'can create a new anonymous review' do
    assert_difference('Review.count', 1) do
      post reviews_path, params: { review: attributes_for(:review, first_name: nil, last_name: nil) }
    end

    assert_redirected_to reviews_path
    follow_redirect!
    assert_flash :success
  end

  test 'can not create a new review without a rating' do
    assert_no_difference('Review.count') do
      post reviews_path, params: { review: attributes_for(:review, rating: nil) }
    end

    assert_flash :error
  end

  test 'can not create a new review without a content' do
    assert_no_difference('Review.count') do
      post reviews_path, params: { review: attributes_for(:review, content: nil) }
    end

    assert_flash :error
  end

  test 'can not create a new review without an email' do
    assert_no_difference('Review.count') do
      post reviews_path, params: { review: attributes_for(:review, email: nil) }
    end

    assert_flash :error
  end

  test 'can destroy a review' do
    review = create(:review)
    
    sign_in create(:user)

    delete review_path(review)

    assert_redirected_to reviews_path
    follow_redirect!
    assert_flash :success
  end
end
