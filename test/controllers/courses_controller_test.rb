require "test_helper"

class CoursesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @language = languages(:one)
    @courses = @language.courses
    @course = @courses.first
  end


  test "should get index" do
    post users_path, params: { user: { name: "John Doe", email: "name@email.com", password: "123456", password_confirmation: "123456", current_language: @language.id   } }
    post sessions_path, params: { user: { email: "name@email.com", password: "123456" } }
    get language_courses_path(@course.language)
    assert_response :success
  end

  test "timeline renders sections and completed lesson progress for the current level" do
    @course.update!(current_level: levels(:one))
    lessons(:one).update!(done: true)

    get timeline_course_path(@course)

    assert_response :success
    assert_select "h2", text: "Module 1: #{sections(:one).name}"
    assert_select '[role="progressbar"][aria-valuenow="100"]'
    assert_select "span", text: "1 de 1 lessons concluídas"
  end

  test "show redirects to the course timeline" do
    get course_path(@course)

    assert_redirected_to timeline_course_path(@course)
  end

  test "should get edit" do
    get edit_language_course_path(language_id: @course.language.id, id: @course.id)
    assert_response :success
  end

  test "should get new" do
    get new_language_course_path(language_id: @course.language.id)
    assert_response :success
  end

  test "should get create" do
    assert_difference("Course.count", 1) do
      post language_courses_path(@language), params: { course: { name: "New Course", description: "A new course description" } }
    end
  end

  test "should update course" do
    patch language_course_path(@course.language, @course), params: { course: { name: "New Course", description: "A new course description" } }

    assert_redirected_to language_courses_path(@course.language)
  end
end
