require 'minitest'
require 'minitest/autorun'
require 'minitest/emoji'
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
    skip
    assert_instance_of Transaction, Transaction.new
  end

  def test_invoice
    assert_instance_of Invoice, @transaction.invoice
  end
end
