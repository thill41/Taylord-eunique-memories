require "test_helper"
require_relative "support/system_helpers"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  # Create _chrome_for_testing directory in root
  # Run the following command to install CFT: `npx @puppeteer/browsers install chrome@stable`
   
  CHROME_BINARY="./_chrome_for_testing/Google\ Chrome\ for\ Testing.app/Contents/MacOS/Google\ Chrome\ for\ Testing"
  
  # If webdrivers are needed, run the following command in a place accessible by all projects like $HOME
  # `npx @puppeteer/browsers install chromedriver@stable`
  # Then link those drivers to ~/.webdrivers
  # `ln -s /path/to/chromedriver/mac_arm-<version.number>/chromedriver-mac-arm64/chromedriver ~/.webdrivers` 

  case ENV.fetch("BROWSER") { "headless_chrome" }
  when "headless_chrome"
    driven_by(:selenium, using: :headless_chrome)
  when "chrome" # original file code
    driven_by(:selenium, using: :chrome, screen_size: [1400, 1400])
  when "headless_firefox"
    driven_by(:selenium, using: :headless_firefox)
  when "firefox"
    driven_by(:selenium, using: :firefox, screen_size: [1400, 1400])
  when "safari"
    # FIXME: Get Safari working for tests
    driven_by(:selenium, using: :safari, screen_size: [1400, 1400])
  when "edge"
    # FIXME: Get MS Edge working for tests
    driven_by(:selenium, using: :edge, screen_size: [1400, 1400])
  end  
end

Capybara.server = :puma, { Silent: true }

class BaseSystemTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers
  include ActionView::RecordIdentifier
  include ActionView::Helpers::DateHelper
  include Support::SystemHelpers
end
