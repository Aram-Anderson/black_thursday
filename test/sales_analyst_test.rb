require 'minitest'
require 'minitest/autorun'
require 'minitest/emoji'
require './lib/sales_analyst'
require './lib/sales_engine'

class SalesAnalystTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv"})

    @sa = SalesAnalyst.new(@se)
  end

  def test_it_exists

    assert_instance_of SalesAnalyst, @sa
  end

  def test_it_can_find_average_items_per_merchant

    assert_equal 2.88, @sa.average_items_per_merchant
  end

  def test_it_can_find_the_average_items_per_merchant_standard_deviation

    assert_equal 3.26, @sa.average_items_per_merchant_standard_deviation
  end

  def test_it_can_find_high_item_count_merchants
    assert_equal 52, @sa.merchants_with_high_item_count.length
  end

  def test_it_can_find_average_price_per_merchant
    assert_equal 16.66, @sa.average_item_price_for_merchant(12334105)
  end

end
