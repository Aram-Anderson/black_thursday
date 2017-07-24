require 'minitest'
require 'minitest/autorun'
require 'minitest/emoji'
require './lib/sales_engine'


class SalesEngineTest < Minitest::Test

  def test_it_exists
    sale = SalesEngine.new

    assert_instance_of SalesEngine, sale

  end

  def test_it_initializes_with_an_instance_of_item_repo
    sale = SalesEngine.new

    assert_instance_of ItemRepo, sale.item_repo
  end

end
