require "test_helper"

class SectionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @section = sections(:one)
  end

  test "new renders the section form" do
    get new_section_path

    assert_response :success
    assert_select "form"
    assert_select "select[name='section[level_id]']"
    assert_select "select[name='section[course_id]']"
    assert_select "select[data-course-filter-target='language']"
    assert_select "option[data-language-id]", minimum: 1
  end

  test "course sections index links directly to each section edit page" do
    course = courses(:one)
    @section.update!(course: course)

    get course_sections_path(course)

    assert_response :success
    assert_select "a[href=?]", edit_section_path(@section), text: /#{@section.name}/
  end

  test "creates a section" do
    assert_difference("Section.count") do
      post sections_path, params: { section: { name: "Greetings", level_id: levels(:one).id } }
    end

    created_section = Section.order(:created_at).last
    assert_redirected_to edit_section_path(created_section)
  end

  test "updates a section" do
    patch section_path(@section), params: { section: { name: "Updated section" } }

    assert_redirected_to edit_section_path(@section)
    assert_equal "Updated section", @section.reload.name
  end

  test "creates a section with a turbo stream response" do
    assert_difference("Section.count") do
      post sections_path,
        params: { section: { name: "Turbo section", level_id: levels(:one).id } },
        as: :turbo_stream
    end

    assert_response :success
    assert_select "turbo-stream[action='update'][target='remote-modal']"
    assert_select "turbo-stream[action='update'][target='flash']"
  end

  test "re-renders an invalid section form with a turbo stream response" do
    post sections_path,
      params: { section: { name: "Section without a level" } },
      as: :turbo_stream

    assert_response :unprocessable_entity
    assert_select "turbo-stream[action='replace'][target='section_form']"
    assert_select "turbo-stream[action='update'][target='flash']"
  end
end
