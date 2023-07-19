require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:penny)
  end

  test "should get new" do
    get sign_in_url
    assert_response :success
  end

  test "should sign in" do
    post sign_in_url, params: {username: "penny42", password: "Secret1*3*5*"}
    assert_redirected_to root_url

    get root_url
    assert_response :success
  end

  test "should not sign in with wrong credentials" do
    post sign_in_url, params: {username: "penny42", password: "SecretWrong1*3"}
    assert_redirected_to sign_in_url(username_hint: "penny42")
    assert_equal "That username or password is incorrect", flash[:alert]
  end
end
