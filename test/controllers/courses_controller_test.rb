require "test_helper"

class CoursesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @course = courses(:one)
  end


  test "should get index" do
    get courses_path
    assert_response :success
  end

  test "should get edit" do
    get edit_language_course_path(@course.language, @course)
    assert_response :success
  end

  test "should get new" do
    get new_course_path
    assert_response :success
  end

  test "should get create" do
    assert_difference('Course.count') do
      post courses_path, params: { course: { name: "New Course", description: "A new course description", language_id: @course.language_id } }
    end
  end

  test "should update course" do
    puts "Updating course with ID: #{@course.id} and language ID: #{@course.language_id}"
    patch language_course_path(@course.language, @course), params: { course: { name: "New Course", description: "A new course descri  ption"} }

    assert_redirected_to course_path(@course)
  end

  # test "should get show" do
  #   get courses_show_url
  #   assert_response :success
  # end
end
