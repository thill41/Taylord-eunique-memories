require 'test_helper'

class PurchaseFlowsTest < BaseIntegrationTest
  setup do
    @package = create(:package)
    @purchase_params = {
      purchase: {
        first_name: 'John',
        last_name: 'Doe',
        email: 'john.doe@example.com',
        package_id: @package.id,
        payment_method_id: 'pm_card_visa'
      }
    }
  end

  test 'should start a new purchase' do
    skip

    get new_purchase_url

    assert_response :success

    assert_select 'h2', text: 'Purchase a Package'
  end

  test 'should create purchase' do
    skip
    
    Stripe::PaymentIntent.stubs(:create).returns(OpenStruct.new(id: 'pi_123', status: 'succeeded'))

    assert_difference('Purchase.count') do
      post purchases_url, params: @purchase_params
    end

    assert_redirected_to purchase_receipt_url(Purchase.last)
    assert_equal "Purchase of #{@package.name} successful", flash[:success]
  end

  test 'should handle Stripe::CardError on create' do
    skip
    
    Stripe::PaymentIntent.stubs(:create).raises(Stripe::CardError.new('Your card was declined.', nil))

    post purchases_url, params: @purchase_params

    assert_redirected_to new_purchase_url
    assert_equal 'Your card was declined.', flash[:error]
    assert_not Purchase.last.output.blank?
  end

  test 'should show receipt' do
    skip
    
    purchase = create(:purchase)
    Stripe::PaymentIntent.stubs(:retrieve).returns(OpenStruct.new(id: purchase.stripe_payment_id, amount: purchase.package.price * 100, status: 'succeeded'))

    get purchase_receipt_url(purchase)
    assert_response :success
    assert_select 'h5', 'Payment Receipt'
    assert_select '.receipt-card' do
      assert_select '.receipt-details' do
        assert_select 'p', /Payment ID: #{purchase.stripe_payment_id}/
      end
    end
  end
end
