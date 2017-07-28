require 'minitest'
require 'minitest/autorun'
require 'minitest/emoji'
require './lib/sales_engine'
require './lib/invoice_repo'
require 'pry'


class InvoiceRepoTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices  => "./data/invoices.csv"})

    @ir = @se.invoices
  end


  def test_it_exists
    assert_instance_of InvoiceRepo, @ir
  end

  def test_it_can_find_all
    assert_equal 4985, @ir.all.length
  end

  def test_it_can_find_by_id
    assert_equal 12334703, @ir.find_by_id(627).merchant_id

    assert_nil @ir.find_by_id(9000)
  end

  def test_it_can_find_all_by_customer_id
    assert_equal 10, @ir.find_all_by_customer_id(22).count

    assert_equal [], @ir.find_all_by_customer_id(9000)
  end

  def test_it_can_find_all_by_merchant_id
    assert_equal 10, @ir.find_all_by_merchant_id(12334688).count

    assert_equal [], @ir.find_all_by_merchant_id(1)
  end

  def test_it_can_find_all_by_status
    assert_equal 1473, @ir.find_all_by_status("pending").count

    assert_equal [], @ir.find_all_by_status("platypus")
  end

end
