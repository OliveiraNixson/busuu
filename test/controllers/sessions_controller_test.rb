require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:admin)
  end

  test "should get new" do
    get new_user_path 
    assert_response :success
  end 


  test "should get create" do
    user = User.create!(name: "Mario", email: "mario@email.com", password: "123", password_confirmation: "123")
    post sessions_path, params: { email: user.email, password: "123" }
    assert_redirected_to pages_path
  end
end
