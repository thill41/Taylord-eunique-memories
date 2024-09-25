require 'application_system_test_case'

class ReviewsTest < BaseSystemTest
  test 'creating a review' do
    visit new_review_path

    fill_in :review_first_name, with: 'John'
    fill_in :review_last_name, with: 'Doe'
    fill_in :review_email, with: 'john.doe@example.com'
    find('label[for=star8]').click
    fill_in :review_content, with: 'Excellent service, highly recommend!'

    click_on 'Create Review'

    assert_current_path reviews_path

    assert_text 'Review was successfully created.'
    assert_text 'John'
    assert_text 'Doe'
    assert_no_text 'john.doe@example.com'
    assert_text 'Excellent service, highly recommend!'
  end

  test 'creating an anonymous review' do
    visit new_review_path


    fill_in :review_email, with: 'john.doe@example.com'
    find('label[for=star5]').click
    fill_in :review_content, with: 'Excellent service, highly recommend!'

    click_on 'Create Review'

    assert_current_path reviews_path

    assert_text 'Review was successfully created.'
    assert_text 'Anonymous'
    assert_no_text 'john.doe@example.com'
    assert_text 'Excellent service, highly recommend!'
  end

  test 'creating a review without a rating' do
    visit new_review_path

    fill_in :review_first_name, with: 'John'
    fill_in :review_last_name, with: 'Doe'
    fill_in :review_email, with: 'jon.doe@example.com'
    fill_in :review_content, with: 'Excellent service, highly recommend!'
   
    click_on 'Create Review'

    assert_text 'There were errors'
  end

  test 'creating a review without a content' do
    visit new_review_path

    fill_in :review_first_name, with: 'John'
    fill_in :review_last_name, with: 'Doe'
    fill_in :review_email, with: 'jdoe@example.com'
    find('label[for=star1]').click

    click_on 'Create Review'

    assert_text 'There were errors'
  end

  test 'creating a review without an email' do
    visit new_review_path

    fill_in :review_first_name, with: 'John'
    fill_in :review_last_name, with: 'Doe'
    find('label[for=star1]').click
    fill_in :review_content, with: 'Excellent service, highly recommend!'

    click_on 'Create Review'

    assert_text 'There were errors'
  end

  test 'destroying a review' do
    review = create(:review)

    visit reviews_path

    assert_text review.first_name
    assert_selector 'button', text: 'Destroy', count: 0

    sign_in create(:user)

    visit reviews_path

    accept_confirm do
      click_on :Delete, match: :first
    end

    assert_text 'Review was successfully destroyed.'
  end
end
