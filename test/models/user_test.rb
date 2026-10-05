require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "Can't create without name" do
    user = User.new(name:"", email:"name@email.com", password: "123", password_confirmation:"123")
    assert_not user.save
  end

  test "Can't create without email" do
    user = User.new(name:"name", email:"", password: "123")
    assert_not user.save
  end
end
