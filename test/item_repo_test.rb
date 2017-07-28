require 'minitest'
require 'minitest/autorun'
require 'minitest/emoji'
require './lib/sales_engine'
require 'pry'


class ItemRepoTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices  => "./data/invoices.csv"})

    @ir = @se.items
  end

  def test_it_exists


    assert_instance_of ItemRepo, @se.items
  end

  def test_it_initializes_with_objects_in_items
    refute @ir.items.empty?
  end

  def test_it_can_add_all

    assert_equal 1367, @ir.all.count
  end

  def test_it_can_find_by_id
    expected = "Glitter scrabble frames"

    assert_equal expected, @ir.find_by_id(263395617).name
  end

  def test_it_can_find_by_name
    expected = 263400121

    assert_equal expected, @ir.find_by_name("Custom Hand Made Miniature Bicycle").id
  end

  def test_it_can_find_all_by_description
    input = "Glitter scrabble frames \n" +
    "\n" +
    "Any colour glitter \n" +
    "Any wording\n" +
    "\n" +
    "Available colour scrabble tiles\n" +
    "Pink\n" +
    "Blue\n" +
    "Black\n" +
    "Wooden"

    assert_equal 1, @ir.find_all_with_description(input).count
  end



  def test_it_can_find_all_by_merchant_id
    assert_equal 6, @ir.find_all_by_merchant_id(12334185).count
  end


  

end
