require_relative '../lib/merchant'
require 'CSV'
require 'simplecov'
SimpleCov.start


class MerchantRepo

  attr_reader :merchants

  def initialize(file, sales_engine)
    @merchants = []
    @sales_engine = sales_engine
    create_merchants(file)
  end

  def create_merchants(file)
      CSV.foreach(file, :headers => true, :header_converters => :symbol, :converters => :all) do |row|
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

  def get_high_achivers(count_hash)
    high_achiving_merchants = []
    mean = @sales_engine.average_items_per_merchant
    std_dev = @sales_engine.average_items_per_merchant_standard_deviation
    count_hash.each do |key, value|
      if value >= std_dev + mean
        high_achiving_merchants << key
      end
    end
    iterate_over_achivers(high_achiving_merchants)
  end

  def iterate_over_achivers(high_achiving_merchants)
    high_achiving_merchants.map do |merchant_id|
      find_by_id(merchant_id)
    end
  end


  def average_average_price_per_merchant
    merch_item_averages = []
    @merchants.each do |merchant|
      merch_item_averages << @sales_engine.average_item_price_for_merchant(merchant.id)
    end
    get_average =  merch_item_averages.reduce(0) do |sum, item_average|
        sum+item_average
      end
      get_average/merchants.count.to_f
  end

  def average_price_per_item_per_merchant_standard_deviation

    Math.sqrt(std_dev_helper_3).round(2)
  end

  def std_dev_helper_3
  summed = std_dev_helper_2.reduce(:+)
  divide_by = (std_dev_helper_2.length)-1
  summed / divide_by

end

  def std_dev_helper_2
    merch_item_averages = std_dev_helper_1
    mean = average_average_price_per_merchant.round(2)
    merch_item_averages.map do |integer|
    (integer - mean) ** 2
    end
  end

  def std_dev_helper_1
  merch_item_averages = []
  @merchants.each do |merchant|
  merch_item_averages = merch_item_averages << @sales_engine.average_item_price_for_merchant(merchant.id)
  end
  merch_item_averages
end
end
