require './lib/item_repo'
require './lib/merchant_repo'
require 'pry'
require 'simplecov'
SimpleCov.start

class SalesEngine

  def self.from_csv(init_hash)
    sales_engine = SalesEngine.new(init_hash)
  end

  attr_reader :items,
              :merchants

  def initialize(init_hash)
    @merchants = MerchantRepo.new(init_hash[:merchants], self)
    @items     = ItemRepo.new(init_hash[:items], self)
  end

  def item(merchant_id)
    @items.find_all_by_merchant_id(merchant_id)
  end

  def merchant(merchant_id)
    @merchants.find_by_id(merchant_id)
  end

  def average_items_per_merchant
    (@items.all.count.to_f / @merchants.all.count.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    @items.average_items_per_merchant_standard_deviation
  end

  def merchants_with_high_item_count
    @items.merchants_with_high_item_count
  end

  def get_high_achivers(count_hash)
    @merchants.get_high_achivers(count_hash)
  end

  def average_item_price_for_merchant(merchant_id)
  arr_of_items = @items.find_all_by_merchant_id(merchant_id)
  @items.average_item_price_for_merchant(arr_of_items)
  end

end
