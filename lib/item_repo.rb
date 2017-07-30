require 'csv'
require_relative 'item'
require_relative 'std_dev_math'
require 'pry'


class ItemRepo

  include StdDevMath

  attr_reader :items,
              :sales_engine

  def initialize(file, sales_engine)
    @items = []
    @sales_engine = sales_engine
    create_items(file)
  end

  def create_items(file)
      CSV.foreach(file, :headers => true,
                        :header_converters =>
                        :symbol,
                        :converters =>
                        :all) do |row|
      @items <<  Item.new(row, self)
      end
  end

  def all
    @items
  end

  def find_by_id(id)
    @items.find {|object| object.id == id}
  end

  def find_multiple_item_ids(item_ids)
    @items.map do |item|
      item_ids.map do |id| item.id == id
      end
    end
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

  def find_all_by_price_in_range(range, prices = [])
    @items.find_all do |object|
      range.cover?(object.unit_price)
    end
  end

  def find_all_by_merchant_id(id)
    things = @items.find_all do |object|
      object.merchant_id == id
    end
  end

  def merchant(merchant_id)
    @sales_engine.merchant(merchant_id)
  end

  def average_items_per_merchant_standard_deviation
    counts = Hash.new 0
    @items.each do |object|
      counts[object.merchant_id] += 1
    end
    standard_deviation(counts)
  end

  def average_item_price_for_merchant(merchant_id)
    array = []
    @items.each do |item|
      if
        item.merchant_id == merchant_id
        array << item.unit_price.to_f
      end
    end
    BigDecimal.new((array.inject(:+) / array.length), 4)
  end

  def average_average_price_per_merchant(merchs)
    prices = merchs.map do |merch|
      find_all_by_merchant_id(merch)
    end
    prices = prices.map do |array|
      array.map {|item| item.unit_price}
    end
    prices = prices.map do |array|
      long = array.length
      unless array[0] == nil
      array.inject(:+) / long
      end
    end
    BigDecimal.new((prices.compact.inject(:+) / prices.length).round(2), 5)
  end

  def merchants_with_high_item_count
     counts = Hash.new 0
      @items.each do |object|
       counts[object.merchant_id] += 1
      end
     @sales_engine.get_high_achivers(counts)
  end

  def golden_items
    compare = std_dev * 2 + get_mean
    @items.find_all do |item|
      item.unit_price > compare
    end
  end

  def std_dev
    Math.sqrt(pre_sq_root).round(2)
  end

  def pre_sq_root
    summed = get_exponent_price_array.inject(:+)
    divide_by = (get_exponent_price_array.length) - 1
    summed / divide_by
  end

  def get_exponent_price_array
    mean = get_mean
    get_price_array.map do |price|
      (price - mean) ** 2
    end
  end

  def get_price_array
    @items.map do |item|
      item.unit_price
    end
  end


  def get_mean
    array = @items.map do |item|
      item.unit_price
    end
    (array.inject(:+) / array.length)
  end

end
