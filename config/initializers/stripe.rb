if Rails.env.production?
  Stripe.api_key = Rails.application.credentials.stripe[:stripe_secret_key]
else
  Stripe.api_key = ENV.fetch('STRIPE_SECRET_KEY', nil)
end
