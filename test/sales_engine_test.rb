require 'minitest'
require 'minitest/autorun'
# require 'minitest/emoji'
require './lib/sales_engine'
require 'pry'


class SalesEngineTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv"})
  end

  def test_sales_engine_init_from_spec

  se = SalesEngine.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv"})
  assert_instance_of MerchantRepo, @se.merchant_repo
  assert_instance_of ItemRepo, @se.item_repo

  end

  def test_it_exists

    assert_instance_of SalesEngine, @se

  end

  def test_it_initializes_with_an_instance_of_item_repo


    assert_instance_of ItemRepo, @se.item_repo
  end

  def test_it_initializes_with_an_instance_of_merchant_repo

    assert_instance_of MerchantRepo, @se.merchant_repo
  end

end