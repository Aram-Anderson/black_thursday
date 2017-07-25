require 'minitest'
require 'minitest/autorun'
# require 'minitest/emoji'
require './lib/sales_engine'
require 'pry'


class SalesEngineTest < Minitest::Test

  def test_sales_engine_init_from_spec

  se = SalesEngine.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv"})
  assert_instance_of MerchantRepo, se.merchant_repo
  assert_instance_of ItemRepo, se.item_repo

  end

  # def test_it_exists
  #   skip
  #   sale = SalesEngine.new
  #
  #   assert_instance_of SalesEngine, sale
  #
  # end
  #
  # def test_it_initializes_with_an_instance_of_item_repo
  #   skip
  #   sale = SalesEngine.from_csv({
  # :items     => "./data/items.csv",
  # :merchants => "./data/merchants.csv"
  # })
  #
  #   assert_instance_of ItemRepo, sale.item_repo
  # end
  #
  # def test_it_initializes_with_an_instance_of_merchant_repo
  #   sale = SalesEngine.new
  #
  #   assert_instance_of MerchantRepo, sale.merchant_repo
  # end

end
