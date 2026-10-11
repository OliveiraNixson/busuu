require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(name: "Test User", email: "test@example.com", password: "password", password_confirmation: "password")
    @user.save
  end


  test "should get new" do
    get root_path
    assert_response :success
  end

  test "should get create" do
    post sessions_path, params: { user: { email: "test@example.com", password: "password" } }
    assert_redirected_to pages_path
  end
end
