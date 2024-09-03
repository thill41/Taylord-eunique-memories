module Support
  module AuthenticationHelpers
    def requires_authentication
      raise(ArgumentError, 'Block missing. Example: requires_authentication {get edit_object_path(object)}') unless block_given?

      yield

      assert_redirected_to('/users/sign_in')
      assert_not(flash[:alert].nil?)
    end
  end
end
