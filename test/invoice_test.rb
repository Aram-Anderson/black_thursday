require 'minitest'
require 'minitest/autorun'
require 'minitest/emoji'
require './lib/invoice'


class InvoiceTest < Minitest::Test

  def setup

    @invoice = Invoice.new({:id => 67, :customer_id => 43322, :merchant_id => 65834, :status => :pending, :created_at  => Time.now, :updated_at  => Time.now}, "invoice_repo")
  end

  def test_it_exists


    assert_instance_of Invoice, @invoice
  end

  def test_it_has_attributes
    assert_equal 67, @invoice.id
    assert_equal 43322, @invoice.customer_id
    assert_equal 65834, @invoice.merchant_id
    assert_equal :pending, @invoice.status
    assert_instance_of Time, @invoice.created_at
    assert_instance_of Time, @invoice.updated_at
  end
end
