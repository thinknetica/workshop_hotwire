require "application_system_test_case"

class SessionsTest < ApplicationSystemTestCase
  setup do
    @user = users(:penny)
  end

  test "visiting home" do
    sign_in_as @user

    assert_text "Signed in as penny42"
  end

  test "signing in" do
    visit sign_in_url
    fill_in "Username", with: "penny42"
    fill_in "Password", with: "Secret1*3*5*"
    click_on "Sign in"

    assert_text "Signed in successfully"
  end

  test "signing out" do
    sign_in_as @user

    click_on "Log out"
    assert_text "Signed in as anonymous"
  end
end
