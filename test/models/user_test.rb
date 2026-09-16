require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    @user_without_email = users(:operator)
    @user_without_name = users(:supervisor)
    @user_without_password = users(:monitor)
  end

  test "can't create user without email" do
    result = @user_without_email.save

    assert_not result
  end

  test "can't create user without name" do
    result = @user_without_email.save

    assert_not result
  end

  test "can't create user without password" do
    user = User.create(name: "Mario", email: "mario@email.com", password: "")

    assert_not user.save
  end
end
