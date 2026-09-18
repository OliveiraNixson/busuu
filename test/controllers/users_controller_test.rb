require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:admin)
  end
  
  test "should get new" do
    get sign_up_path
    assert_response :success
  end

  test "shoud create user" do
    post users_path(), params: {
      user: {
        name: "Mario", email: "mario@email.com", password: "123", password_confirmation: "123"
      }
    }
    assert_redirected_to pages_path
  end
end
