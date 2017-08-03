require 'minitest'
require 'minitest/autorun'
require './lib/day_of_week'

class DayOfTheWeekTest < Minitest::Test
  include DayOfWeek

  def test_it_has_all_days
    day = [0, 1, 2, 3, 4, 5, 6]
    expected = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]

    assert_equal expected, what_day_is_it?(day)
  end

end
