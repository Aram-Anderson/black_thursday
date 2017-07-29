require 'minitest'
require 'minitest/autorun'
require_relative '../lib/merchant'
require_relative '../lib/sales_engine'
require_relative '../lib/merchant_repo'
require 'pry'


class MerchantTest < Minitest::Test

  def setup
    @merchant = Merchant.new({:id => 2, :name => "Frank", :created_at => 6, :updated_at => 7}, "merchants")
  end

  def test_it_has_an_id

    assert_equal 2, @merchant.id
  end

  def test_it_has_a_name

    assert_equal "Frank", @merchant.name
  end

  def test_it_has_a_created_at
    assert_equal 6, @merchant.created_at
  end

  def test_it_has_an_updated_at
    assert_equal 7, @merchant.updated_at
  end

end
