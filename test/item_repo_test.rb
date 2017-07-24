require 'minitest'
require 'minitest/autorun'
require 'minitest/emoji'
require './lib/item_repo'


class ItemRepoTest < Minitest::Test

  def test_it_exists
    repo = ItemRepo.new

    assert_instance_of ItemRepo, repo
  end

  def test_it_initializes_with_an_empty_array_for_items
    repo = ItemRepo.new

    assert_equal [], repo.items
  end

end
