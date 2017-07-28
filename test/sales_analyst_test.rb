require 'minitest'
require 'minitest/autorun'
require 'minitest/emoji'
require './lib/sales_analyst'
require './lib/sales_engine'

class SalesAnalystTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices  => "./data/invoices.csv"})

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

  def test_it_can_find_average_invoices_per_merchant


    assert_equal 10.49, @sa.average_invoices_per_merchant
  end

  def test_it_can_find_the_average_invoices_per_merchant_standard_deviation

    assert_equal 3.29, @sa.average_invoices_per_merchant_standard_deviation
  end
end
