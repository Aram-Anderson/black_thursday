require 'minitest'
require 'minitest/autorun'
require 'minitest/emoji'
require './lib/item'

class ItemTest < Minitest::Test

  def setup
    @item = Item.new({:id => 44, :name => "Stuff 4 Sale", :description => "Junk", :unit_price => 7465, :merchant_id => 332, :created_at => 54, :updated_at => 75})
  end

  def test_it_has_an_id

    assert_equal 44, @item.id
  end

  def test_it_has_a_name

    assert_equal "Stuff 4 Sale", @item.name
  end

  def test_it_has_a_description
    assert_equal "Junk", @item.description
  end

  def test_it_has_a_unit_price

    assert_equal 7465, @item.unit_price
  end

  def test_it_has_a_merchant_id

    assert_equal 332, @item.merchant_id
  end

  def test_it_has_a_created_at

    assert_equal 54, @item.created_at
  end

  def test_it_has_an_updated_at

    assert_equal 75, @item.updated_at
  end

  def test_it_can_convert_unit_price_to_dollars

    assert_equal 74.65, @item.unit_price_to_dollars
  end
end
