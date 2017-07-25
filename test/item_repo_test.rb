require 'minitest'
require 'minitest/autorun'
require 'minitest/emoji'
require './lib/sales_engine'
require 'pry'


class ItemRepoTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv"})
  end

  def test_it_exists


    assert_instance_of ItemRepo, @se.item_repo.items
  end

  def test_it_initializes_with_an_empty_array_for_items
    binding.pry
    assert_equal [], se.item_repo.items
  end

end
