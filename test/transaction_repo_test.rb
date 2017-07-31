require 'minitest'
require 'minitest/autorun'
require './lib/transaction_repo'
require 'pry'

class TransactionRepoTest < Minitest::Test

  def setup
    @tr = TransactionRepo.new("./data/fixture_transactions.csv", "stuff")
  end

  def test_it_exists
    assert_instance_of TransactionRepo, @tr
  end

  def test_it_can_get_all
    assert_equal 300, @tr.all.count
  end

  def test_it_can_find_by_id
    assert_equal "1113", @tr.find_by_id(40).credit_card_expiration_date
  end

  def test_it_can_find_all_by_invoice_id
    assert_equal 1, @tr.find_all_by_invoice_id(2777).count
    assert_equal [], @tr.find_all_by_invoice_id(10000)
  end

  def test_it_can_find_all_by_credit_card_number
    assert_equal 1, @tr.find_all_by_credit_card_number(4469794222279759).count
  end

  def test_if_can_find_all_by_result
    assert_equal 243, @tr.find_all_by_result("success").length
    assert_equal 57, @tr.find_all_by_result("failed").length
  end

end
