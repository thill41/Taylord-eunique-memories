class PurchasesController < ApplicationController
  skip_before_action :authenticate_user!
  def new
    @packages = Package.all
  end

  def create
    package = Package.find(purchase_params[:package_id])

    @purchase = package.purchases.create(
      first_name: purchase_params[:first_name],
      last_name: purchase_params[:last_name],
      email: purchase_params[:email],
      package: package,
      status: 'pending'
    )

    # stripe_payment_id: payment_intent.id,
    @payment_intent = Stripe::PaymentIntent.create({
                                                     amount: (package.price * 100).to_i,
                                                     currency: 'usd',
                                                     payment_method: purchase_params[:payment_method_id],
                                                     confirm: true,
                                                     return_url: purchase_receipt_url(@purchase)
                                                   })
    redirect_to purchase_receipt_url(@purchase), success: "Purchase of #{package.name} successful"
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_purchase_path
    
    @purchase.update(status: 'failed', output: "#{e.message}\n#{e.backtrace.join("\n")}")
  ensure
    if @payment_intent
      @purchase.update(stripe_payment_id: @payment_intent.id,
                       status: @payment_intent.status)
    end
  end

  def receipt
    @purchase = Purchase.find(params[:purchase_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@purchase.stripe_payment_id)
  end

  private

  def purchase_params
    params.require(:purchase).permit(:first_name, :last_name, :email, :package_id, :payment_method_id)
  end
end
