require 'minitest'
require 'minitest/autorun'
require './lib/transaction'
require './lib/sales_engine'

class TransactionTest < Minitest::Test

def setup
  @se = SalesEngine.from_csv({
  :items => "./data/items.csv",
  :merchants => "./data/merchants.csv",
  :invoices => "./data/invoices.csv",
  :invoice_items => "./data/invoice_items.csv",
  :transactions => "./data/transactions.csv",
  :customers => "./data/customers.csv"
  })

  @transaction = @se.transactions.find_by_id(40)
end

  def test_it_exists
    assert_instance_of Transaction, @transaction
  end

  def test_it_has_attributes
    assert_equal 40, @transaction.id
    assert_equal 14, @transaction.invoice_id
    assert_equal 4469794222279759, @transaction.credit_card_number
    assert_equal "1113", @transaction.credit_card_expiration_date
    assert_equal "success", @transaction.result
    assert_instance_of Time, @transaction.created_at
    assert_instance_of Time, @transaction.updated_at
  end

  def test_invoice
    assert_instance_of Invoice, @transaction.invoice
  end
end
