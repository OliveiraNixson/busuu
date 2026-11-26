require 'test_helper'

class LevelDecoratorTest < Draper::TestCase
    setup do
        @level = levels(:one)
    end

    test "decorated level should respond to name" do
        assert_equal @level.decorate.description, "#{@level.name} - #{@level.code}"
    end
end
