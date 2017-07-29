require 'minitest'
require 'minitest/autorun'
require 'minitest/emoji'
require './lib/invoice_item'

class InvoiceItemTest < Minitest::Test

  def test_it_exists
    assert_instance_of InvoiceItem, InvoiceItem.new
  end

end
