module Support
  module SystemHelpers
    # expect bootstrap alert class (e.g. alert-success)
    def assert_alert(klass)
      wants = case klass
              when :notice then 'primary'
              when :alert then 'primary'
              when :success then 'success'
              when :error then 'danger'
              else
                "Unrecognized alert class: #{klass}"
              end

      assert_not(find(".alert.alert-#{wants}").text.blank?)
    end

    def assert_unauthorized_request
      assert_equal(root_path, current_path)
      # FIXME: message shows without CSS
      # assert_not page.find('.alert').text.blank?
    end
  end
end
