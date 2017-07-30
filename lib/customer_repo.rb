require 'csv'
require_relative 'customer'

class CustomerRepo

  attr_reader :customers

  def initialize(file, sales_engine)
    @sales_engine = sales_engine
    @customers = []
    from_csv(file)
  end

  def from_csv(file)
    CSV.foreach(file, :headers => true,
                      :header_converters =>
                      :symbol,
                      :converters =>
                      :all) do |row|
    @customers <<  Customer.new(row)
    end
  end

  def all
    @customers
  end

  def find_by_id(id)
    @customers.find {|customer| customer.id == id}
  end

  def find_all_by_first_name(name)
    @customers.find_all do |customer|
      customer.first_name.include? name
    end
  end

  def find_all_by_last_name(name)
    @customers.find_all do |customer|
      customer.last_name.include? name
    end
  end

end
