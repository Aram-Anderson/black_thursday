require 'minitest'
require 'minitest/autorun'
require './lib/item'
require './lib/sales_engine'
require 'pry'

class ItemTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
    :items => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions => "./data/transactions.csv",
    :customers => "./data/customers.csv"
    })

    @item = @se.items.find_by_id(263395617)
  end

  def test_it_has_an_id

    assert_equal 263395617, @item.id
  end

  def test_it_has_a_name

    assert_equal "Glitter scrabble frames", @item.name
  end

  def test_it_has_a_description
    assert_equal "Glitter scrabble frames \n" +
    "\n" +
    "Any colour glitter \n" +
    "Any wording\n" +
    "\n" +
    "Available colour scrabble tiles\n" +
    "Pink\n" +
    "Blue\n" +
    "Black\n" +
    "Wooden", @item.description
  end

  def test_it_has_a_unit_price

    assert_equal 13.00, @item.unit_price.to_f
  end

  def test_it_has_a_merchant_id

    assert_equal 12334185, @item.merchant_id
  end

  def test_it_has_a_created_at

    assert_equal Time, @item.created_at.class
  end

  def test_it_has_an_updated_at

    assert_equal Time, @item.updated_at.class
  end

  def test_it_can_convert_unit_price_to_dollars

    assert_equal 74.65, @item.unit_price_to_dollars(7465.to_f)
  end
end
