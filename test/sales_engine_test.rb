require 'minitest'
require 'minitest/autorun'
require_relative '../lib/sales_engine'
require 'pry'


class SalesEngineTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
    :items => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions => "./data/transactions.csv",
    :customers => "./data/customers.csv"
    })
  end

  def test_it_exists
    assert_instance_of SalesEngine, @se
  end

  def test_sales_engine_init_from_spec

    assert_instance_of MerchantRepo, @se.merchants
    assert_instance_of ItemRepo, @se.items
  end

  def test_it_initializes_with_an_instance_of_item_repo

    assert_instance_of ItemRepo, @se.items
  end

  def test_it_initializes_with_an_instance_of_merchant_repo

    assert_instance_of MerchantRepo, @se.merchants
  end

  def test_it_can_find_items_from_instance_of_merchant
    merchant = @se.merchants.find_by_id(12334195)

    assert_equal 20, merchant.items.count
  end

  def test_it_can_find_merchants_by_id
    merchant = @se.merchants.find_by_id(12334145)

    assert_equal "BowlsByChris", merchant.name
  end

  def test_it_can_find_merchants_from_instance_of_item

    item = @se.items.find_all_by_merchant_id(12334195).first

    assert_equal "FlavienCouche", item.merchant.name
  end

  def test_it_can_find_all_invoices_by_merchant_id
    merchant = @se.merchants.find_by_id(12336161)

    assert_equal 9, merchant.invoices.count
  end

  def test_it_can_find_merchant_by_invoice_id
    invoice = @se.invoices.find_by_id(30)
    assert_equal 12334208, invoice.merchant.id
  end

end
