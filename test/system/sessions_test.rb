require "application_system_test_case"

class SessionsTest < ApplicationSystemTestCase
  setup do
    @user = users(:penny)
  end

  test "visiting home" do
    sign_in_as @user

    within "nav" do
      assert_text "@penny42"
    end
  end

  test "signing in" do
    visit sign_in_url
    fill_in "username", with: "penny42"
    fill_in "password", with: "Secret1*3*5*"

    click_on "Log in"

    assert_text "Signed in successfully"
  end

  test "signing out" do
    sign_in_as @user

    within "nav" do
      click_on "Sign out"
    end

    within "nav" do
      assert_link "Log in"
    end
  end
end
