require "application_system_test_case"

class RegistrationsTest < ApplicationSystemTestCase
  test "signing up" do
    visit sign_up_url

    fill_in "username", with: "penny"
    fill_in "password", with: "Secret6*4*2*"
    fill_in "password_confirmation", with: "Secret6*4*2*"
    click_on "Sign up"

    assert_text "Welcome! You have signed up successfully"
  end
end
