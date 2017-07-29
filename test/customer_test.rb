require 'minitest'
require 'minitest/autorun'
require 'minitest/nyan_cat'
require 'time'
require './lib/customer'

class CustomerTest < Minitest::Test

  def setup
    @customer = Customer.new({
                              :id => 6,
                              :first_name => "Joan",
                              :last_name => "Clarke",
                              :created_at => Time.now,
                              :updated_at => Time.now
                            })
  end

  def test_it_exists
    assert_instance_of Customer, @customer
  end

  def test_it_has_attributes
    assert_equal 6, @customer.id
    assert_equal "Joan", @customer.first_name
    assert_equal "Clarke", @customer.last_name
    assert_equal Time, @customer.created_at.class
    assert_equal Time, @customer.updated_at.class
  end

end
