require 'CSV'
require './lib/item'

class ItemRepo

  attr_reader :items,
              :sales_engine

  def initialize(file, sales_engine)
    @items = []
    @sales_engine = sales_engine
    create_items(file)
  end

  def create_items(file)
      CSV.foreach(file, :headers => true, :header_converters => :symbol, :converters => :all) do |row|
      @items <<  Item.new(row)
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
    stuff = @items.find_all do |object|
      object.description.to_s.downcase == describe.downcase
    end
    stuff
  end

  def find_all_by_price(cost)
    objects = @items.find_all {|object| object.unit_price == cost }
  end

  def find_all_by_price_in_range(range, prices = [])
    @items.each do |x|
      if range.cover?(x.unit_price)
        prices << x
      end
    end
    prices
  end

  def find_all_by_merchant_id(id, capitalists = [])
    @items.each do |object|
      if object.merchant_id == id
        capitalists << object
      end
    end
    capitalists
  end
end
