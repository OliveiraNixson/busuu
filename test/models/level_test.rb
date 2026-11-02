require "test_helper"

class LevelTest < ActiveSupport::TestCase
  test "should not save level without name" do
    level = Level.new(code: "L1")
    assert_not level.save, "Saved the level without a name"
  end

  test "should not save level without code" do
    level = Level.new(name: "Level 1")
    assert_not level.save, "Saved the level without a code"
  end
end
