require "test_helper"

class LanguagesControllerTest < ActionDispatch::IntegrationTest
  setup do
  end

  test "should get index" do
    get languages_index_path(key: [ "value", "" ])
    assert_response :success
  end

  test "should get new" do
    get new_language_path
    assert_response :success
  end

  test "should get edit" do
    get edit_language_path(languages(:one))
    assert_response :success
  end

  test "should get update" do
    patch language_path(languages(:one)), params: { language: { name: "Updated Language" } }
    assert_response :redirect
  end

  test "should get create" do
    post languages_path, params: { language: { name: "New Language", flag: "new_flag.png" } }
    assert_response :redirect
  end
end
