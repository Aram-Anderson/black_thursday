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

  def test_it_can_find_high_item_count_merchants
    assert_equal 52, @sa.merchants_with_high_item_count.length
  end

  def test_it_can_find_average_price_per_merchant
    assert_equal 16.66, @sa.average_item_price_for_merchant(12334105)

    assert_equal 76.67, @sa.average_item_price_for_merchant(12334155)

    assert_equal 50.00, @sa.average_item_price_for_merchant( 12335403)
  end

  def test_average_average_price_per_merchant
    assert_equal 350.29, @sa.average_average_price_per_merchant
  end

  def test_golden_items
    assert_equal 5, @sa.golden_items.count
  end

  def test_it_can_find_top_performing_merchants_from_invoice_count
    assert_equal 12, @sa.top_merchants_by_invoice_count.count
  end

  def test_it_can_find_bottom_performing_merchants_by_invoice
    assert_equal 4, @sa.bottom_merchants_by_invoice_count.count
  end

  def test_it_can_find_top_days_by_invoice_count
    assert_equal ["Wednesday"], @sa.top_days_by_invoice_count
  end

  def test_it_can_return_percentage_of_invoices_by_status
    assert_equal 29.55, @sa.invoice_status(:pending)
  end
end
