require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
    test 'full title helper' do
        assert_equal full_title, "hello" # page 147 TODO
        assert_equal full_title("Help"), "hello"
    end
end
