require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: ENV.fetch("HEADLESS", false) ? :headless_chrome : :chrome
end
