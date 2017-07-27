require 'CSV'
require_relative 'item'
require 'pry'
require 'bigdecimal'

class ItemRepo

  attr_reader :items,
              :sales_engine

  def initialize(file, sales_engine)
    @items = []
    @sales_engine = sales_engine
    create_items(file)
  end

  def create_items(file)
      CSV.foreach(file, :headers => true, :header_converters => :symbol,
      :converters => :all) do |row|
      @items <<  Item.new(row, self)
      end
  end

  def all
    @items
  end

  def find_by_id(id)
    @items.find {|object| object.id == id}
  end

  def find_by_name(name)
    @items.find { |object| object.name.downcase == name.downcase }
  end

  def find_all_with_description(describe)
    @items.find_all do |object|
      object.description.to_s.downcase == describe.downcase
    end
  end

  def find_all_by_price(cost)
    @items.find_all {|object| object.unit_price == cost }
  end

  def find_all_by_price_in_range(range)
    @items.find_all do |object|
      range.cover?(object.unit_price)
    end
  end

  def find_all_by_merchant_id(id)
    @items.find_all do |object|
      object.merchant_id == id
    end
  end

  def merchant(merchant_id)
    @sales_engine.merchant(merchant_id)
  end

  def average_items_per_merchant_standard_deviation
    Math.sqrt(gets_sums_sqrt).round(2)
  end

  def gets_sums_sqrt
    summed = get_pre_sum_std_dev_array.sum
    divide_by = (get_pre_sum_std_dev_array.length) -1
    summed / divide_by
  end

  def get_pre_sum_std_dev_array
    mean = @sales_engine.average_items_per_merchant
    pre_sum_std_dev_array = gets_pre_anything_standard_deviation_array.map do |integer|
      (integer - mean) ** 2
    end
  end

  def gets_pre_anything_standard_deviation_array
    counts = Hash.new 0
    @items.each do |object|
      counts[object.merchant_id] += 1
    end
    counts.values
  end

end
