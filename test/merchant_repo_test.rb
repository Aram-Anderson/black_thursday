require 'minitest'
require 'minitest/autorun'
require './lib/sales_engine'
require 'pry'


class MerchantRepoTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
    :items => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions => "./data/transactions.csv",
    :customers => "./data/customers.csv"
    })

    @mr = @se.merchants
  end

  def test_it_exists

    assert_instance_of MerchantRepo, @mr
  end

  def test_it_creates_merchants_on_init

    refute @mr.merchants.empty?
  end

  def test_it_can_find_all

    assert_equal 475, @mr.all.count
  end

  def test_it_can_find_by_id
    assert_equal "JUSTEmonsters", @mr.find_by_id(12334165).name
  end

  def test_it_can_find_by_name

    assert_equal 12334556, @mr.find_by_name("GranadaFotoBaby").id
  end

  def test_it_can_find_all_by_name_fragment

    assert_equal 5, @mr.find_all_by_name("Gran").count
  end

end
