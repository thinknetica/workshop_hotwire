require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(username: "testuser", password: "password123", password_confirmation: "password123")
  end

  test "should be valid" do
    assert @user.valid?, @user.errors.full_messages
  end

  test "username should be present" do
    @user.username = ""
    assert_not @user.valid?
  end

  test "username should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test "password should be at least 12 characters" do
    @user.password = "password"
    assert_not @user.valid?
  end

  test "should authenticate with correct password" do
    assert_equal @user, @user.authenticate("password123")
  end

  test "should not authenticate with incorrect password" do
    assert_not @user.authenticate("wrongpassword")
  end

  # Make sure freezolite is working
  test "PREFIX must be frozen" do
    assert User::PREFIX.frozen?
  end
end
