require 'minitest'
require 'minitest/autorun'
require 'time'
require './lib/customer'
require './lib/sales_engine'

class CustomerTest < Minitest::Test

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

  def test_it_has_attributes
    customer = Customer.new({
                             :id => 6,
                             :first_name => "Joan",
                             :last_name => "Clarke",
                             :created_at => Time.now,
                             :updated_at => Time.now
                           })
    assert_equal 6, customer.id
    assert_equal "Joan", customer.first_name
    assert_equal "Clarke", customer.last_name
    assert_equal Time, customer.created_at.class
    assert_equal Time, customer.updated_at.class
  end

  def test_customer_can_find_all_its_merchants

    customer = @se.customers.find_by_id(30)

    assert_equal 5, customer.merchants.count
    assert_equal Merchant, customer.merchants[0].class

  end

end
