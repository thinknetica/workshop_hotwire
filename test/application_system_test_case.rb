require "test_helper"
require "capybara/cuprite"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :cuprite, screen_size: [1400, 1400]

  def sign_in_as(user)
    visit sign_in_url
    fill_in :username, with: user.username
    fill_in :password, with: "Secret1*3*5*"
    click_on "Log in"

    assert_current_path root_url
    user
  end
end
