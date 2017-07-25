require 'minitest'
require 'minitest/autorun'
require './lib/merchant'
require './lib/sales_engine'
require './lib/merchant_repo'
require 'pry'


class MerchantTest < Minitest::Test

  def test_sales_engine_init_from_spec

  se = SalesEngine.from_csv({ :merchants => "./data/merchants.csv",})
  assert_instance_of MerchantRepo, se
binding.pry
  end

  def test_merchantrepo_has_merchants

      se = SalesEngine.from_csv({ :merchants => "./data/merchants.csv",})

      mr = se.merchants

      assert_equal 10, mr.merchants.length

  end


end
