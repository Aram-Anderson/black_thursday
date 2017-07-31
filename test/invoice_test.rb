require 'minitest'
require 'minitest/autorun'
require './lib/invoice'
require './lib/sales_engine'

class InvoiceTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
    :items => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions => "./data/transactions.csv",
    :customers => "./data/customers.csv"
    })

    @invoice = @se.invoices.find_by_id(20)
  end

  def test_it_exists
    assert_instance_of Invoice, @invoice
  end

  def test_it_has_attributes
    assert_equal 20, @invoice.id
    assert_equal 5, @invoice.customer_id
    assert_equal 12336163, @invoice.merchant_id
    assert_equal :shipped, @invoice.status
    assert_instance_of Time, @invoice.created_at
    assert_instance_of Time, @invoice.updated_at
  end

  def test_it_can_find_items_by_invoice_id
    assert_equal Item, @invoice.items[0].class
  end

  def test_transactions
    assert_equal 3, @invoice.transactions.count
  end

  def test_customer
    assert_instance_of Customer, @invoice.customer
  end

  def test_invoice_is_paid_in_full
    assert_equal true, @invoice.is_paid_in_full?
  end

end
