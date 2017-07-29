require 'minitest'
require 'minitest/autorun'
require 'minitest/emoji'
require './lib/transaction'

class TransactionTest < Minitest::Test
  def test_it_exists
    assert_instance_of Transaction, Transaction.new
  end
end
