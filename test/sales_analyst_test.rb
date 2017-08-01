require 'minitest'
require 'minitest/autorun'
require './lib/sales_analyst'
require './lib/sales_engine'

class SalesAnalystTest < Minitest::Test
  #
  # def setup
  #   @se = SalesEngine.from_csv({
  #   :items => "./data/items.csv",
  #   :merchants => "./data/merchants.csv",
  #   :invoices => "./data/invoices.csv",
  #   :invoice_items => "./data/invoice_items.csv",
  #   :transactions => "./data/transactions.csv",
  #   :customers => "./data/customers.csv"
  #   })
  #
  #   @sa = SalesAnalyst.new(@se)
  # end

  def test_it_exists
skip
    assert_instance_of SalesAnalyst, @sa
  end

  def test_it_can_find_average_items_per_merchant
skip
    assert_equal 2.88, @sa.average_items_per_merchant
  end

  def test_it_can_find_the_average_items_per_merchant_standard_deviation
skip
    assert_equal 3.26, @sa.average_items_per_merchant_standard_deviation
  end

  def test_it_can_find_average_invoices_per_merchant
skip

    assert_equal 10.49, @sa.average_invoices_per_merchant
  end

  def  test_it_can_find_the_average_invoices_per_merchant_standard_deviation
skip
    assert_equal 3.29, @sa.average_invoices_per_merchant_standard_deviation
  end

  def test_it_can_find_high_item_count_merchants
skip
    assert_equal 52, @sa.merchants_with_high_item_count.length
  end

  def test_it_can_find_average_price_per_merchant
skip
    assert_equal 16.66, @sa.average_item_price_for_merchant(12334105)

    assert_equal 76.67, @sa.average_item_price_for_merchant(12334155)

    assert_equal 50.00, @sa.average_item_price_for_merchant( 12335403)
  end

  def test_average_average_price_per_merchant
skip
    assert_equal 350.29, @sa.average_average_price_per_merchant
  end

  def test_golden_items
skip
    assert_equal 5, @sa.golden_items.count
  end

  def test_it_can_find_top_performing_merchants_from_invoice_count
skip
    assert_equal 12, @sa.top_merchants_by_invoice_count.count
  end

  def test_it_can_find_bottom_performing_merchants_by_invoice
skip
    assert_equal 4, @sa.bottom_merchants_by_invoice_count.count
  end

  def test_it_can_find_top_days_by_invoice_count
skip
    assert_equal ["Wednesday"], @sa.top_days_by_invoice_count
  end

  def test_it_can_return_percentage_of_invoices_by_status
skip
    assert_equal 29.55, @sa.invoice_status(:pending)
  end

  def test_it_can_find_total_revenue_by_date
skip
    date = Time.parse("2009-02-07")
    assert_equal 21067.77, @sa.total_revenue_by_date(date)
  end

  def test_it_returns_top_revenue_earners
skip
    expected = @sa.top_revenue_earners(10)
    first = expected.first
    last = expected.last

    assert_equal 10, expected.length

    assert_instance_of Merchant, first
    assert_equal 12334634, first.id

    assert_instance_of Merchant, last
    assert_equal 12335747, last.id
  end

  def test_it_returns_merchants_with_pending_invoices
    @se = SalesEngine.from_csv({
    :items => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions => "./data/transactions.csv",
    :customers => "./data/customers.csv"
    })

    @sa = SalesAnalyst.new(@se)

    assert_equal 467,  @sa.merchants_with_pending_invoices.length
    assert_equal Merchant, @sa.merchants_with_pending_invoices.first.class
  end

  def test_it_can_find_revenue_for_a_merchant


    @se = SalesEngine.from_csv({
    :items => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions => "./data/transactions.csv",
    :customers => "./data/customers.csv"
    })

    @sa = SalesAnalyst.new(@se)
      assert_equal 5, @sa.revenue_by_merchant(12334194)
  end

end
