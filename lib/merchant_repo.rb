require_relative 'merchant'
require 'CSV'

class MerchantRepo


  attr_reader :merchants

  def initialize(file, sales_engine)
    @merchants = []
    @sales_engine = sales_engine
    create_merchants(file)
  end

  def create_merchants(file)
      CSV.foreach(file, :headers => true, :header_converters => :symbol,
      :converters => :all) do |row|
      @merchants <<  Merchant.new(row, self)
    end
  end

  def all
    @merchants
  end

  def find_by_id(id)
    @merchants.find { |object| object.id == id }
  end

  def find_by_name(name)
    @merchants.find {|object| object.name.downcase == name.downcase }
  end

  def find_all_by_name(frag)
    @merchants.find_all {|object| object.name.downcase.include? frag.downcase}
  end

  def item(merchant_id)
    @sales_engine.item(merchant_id)
  end
end
