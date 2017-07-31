require 'minitest'
require 'minitest/autorun'
require './lib/customer_repo'

class CustomerRepoTest < Minitest::Test

  def setup
    @cr = CustomerRepo.new
    @cr.from_csv('./data/customers.csv')
  end

  def test_it_exists
    assert_instance_of CustomerRepo, @cr
  end

  def test_it_can_find_all
    assert_equal 1000, @cr.all.count
  end

  def test_it_can_find_by_id
    assert_equal "Gulgowski", @cr.find_by_id(35).last_name
  end

  def test_it_can_find_all_by_first_name
    assert_equal 1, @cr.find_all_by_first_name("Pam").count
  end

  def test_if_can_find_all_by_last_name
    assert_equal 2, @cr.find_all_by_last_name("Wiz").count
  end

end
