require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'
require 'pry'


class SalesEngineTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv"})
  end

  def test_sales_engine_init_from_spec

  assert_instance_of MerchantRepo, @se.merchants
  assert_instance_of ItemRepo, @se.items

  end

  def test_it_exists

    assert_instance_of SalesEngine, @se

  end

  def test_it_initializes_with_an_instance_of_item_repo


    assert_instance_of ItemRepo, @se.items
  end

  def test_it_initializes_with_an_instance_of_merchant_repo

    assert_instance_of MerchantRepo, @se.merchants
  end

  def test_it_can_find_merchants_from_instance_of_item

    item = @se.items.find_by_id(263395617)

    assert_equal "Madewithgitterxx", item.merchant.name
  end

end
