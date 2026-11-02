require "test_helper"

class LanguageTest < ActiveSupport::TestCase
  test "should not save language without flag" do
    language = Language.new(name: "English")
    assert_not language.save, "Saved the language without a flag"
  end

  test "should not save language without name" do
    language = Language.new(flag: "US")
    assert_not language.save, "Saved the language without a name"
  end
end
