require 'minitest'
require 'minitest/autorun'
require 'minitest/emoji'
require './lib/transaction_repo'
require 'pry'

class TransactionRepoTest < Minitest::Test

  def setup
    @tr = TransactionRepo.new
    @tr.from_csv("./data/fixture_transactions.csv")
  end

  def test_it_exists
    assert_instance_of TransactionRepo, TransactionRepo.new
  end

  def test_it_can_load_from_csv
    tr = TransactionRepo.new
    assert tr.transactions.empty?
    tr.from_csv("./data/fixture_transactions.csv")
    refute tr.transactions.empty?
  end

  def test_it_can_get_all
    assert_equal 300, @tr.all.count
  end

  def test_it_can_find_by_id
    assert_equal 616, @tr.find_by_id(25).credit_card_expiration_date
  end

  def test_it_can_find_all_by_invoice_id
    assert_equal 1, @tr.find_all_by_invoice_id(2777).count
    assert_equal [], @tr.find_all_by_invoice_id(10000)
  end

  def test_it_can_find_all_by_credit_card_number
    assert_equal 1, @tr.find_all_by_credit_card_number(4.17782E+15).count
  end

  def test_if_can_find_all_by_result
    assert_equal 243, @tr.find_all_by_result("success").length
    assert_equal 57, @tr.find_all_by_result("failed").length
  end

end
