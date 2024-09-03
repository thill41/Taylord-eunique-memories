module Support
  module IntegrationHelpers
    # expects a flash key
    def assert_flash(flash_key)
      raise ArgumentError, 'flash_key must be a Symbol' unless flash_key.is_a?(Symbol)

      assert_not(flash[flash_key].blank?)
    end

    def assert_policy
      assert_response(:redirect)
      assert_redirected_to(root_path)
      follow_redirect!
      assert_not(flash[:alert].blank?)
    end
  end
end
