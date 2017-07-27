require 'CSV'
require_relative 'item'
require 'pry'
require 'bigdecimal'
require_relative 'sales_analyst_math'


class ItemRepo
  include SalesAnalystMath

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

end
