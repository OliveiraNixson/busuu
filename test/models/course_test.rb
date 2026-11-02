require "test_helper"

class CourseTest < ActiveSupport::TestCase
  test "should not save course without name" do
    course = Course.new(description: "A course description", language_id: 1)
    assert_not course.save, "Saved the course without a name"
  end

  test "should not save course without description" do
    course = Course.new(name: "Course Name", language_id: 1)
    assert_not course.save, "Saved the course without a description"
  end
end
