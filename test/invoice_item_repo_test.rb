require 'minitest'
require 'minitest/autorun'
require 'minitest/emoji'
require './lib/invoice_item_repo'

class InvoiceItemRepoTest < Minitest::Test

  def setup
    @ir = InvoiceItemRepo.new
    @ir.from_csv("./data/fixture_for_invoice_items.csv")
  end

  def test_it_exists
    assert_instance_of InvoiceItemRepo, InvoiceItemRepo.new
  end

  def test_it_can_load_from_csv
    ir = InvoiceItemRepo.new
    assert ir.invoice_items.empty?
    ir.from_csv("./data/fixture_for_invoice_items.csv")
    refute ir.invoice_items.empty?
  end

  def test_it_can_get_all
    assert_equal 503, @ir.all.count
  end

  def test_it_can_find_by_id

    assert_equal 263529264, @ir.find_by_id(9).item_id
  end

  def test_it_can_find_all_by_id
    assert_equal 2, @ir.find_all_by_item_id(263529264).count
    assert_equal [], @ir.find_all_by_item_id(4)
  end

  def test_it_can_find_all_by_invoice_id
    assert_equal 8, @ir.find_all_by_invoice_id(8).count
    assert_equal [], @ir.find_all_by_invoice_id(5000)
  end



end
