
require_relative 'item_repo'
require_relative 'merchant_repo'
require_relative 'invoice_repo'

require_relative '../lib/item_repo'
require_relative '../lib/merchant_repo'

require 'pry'
require 'simplecov'


class SalesEngine

  def self.from_csv(init_hash)
    sales_engine = SalesEngine.new(init_hash)
  end

  attr_reader :items,
              :merchants,
              :invoices

  def initialize(init_hash)
    @merchants = MerchantRepo.new(init_hash[:merchants], self)
    @items     = ItemRepo.new(init_hash[:items], self)
    @invoices  = InvoiceRepo.new(init_hash[:invoices], self)
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

  def average_average_price_per_merchant
    @merchants.average_average_price_per_merchant
  end

  def golden_items
  std_dev =   @merchants.average_price_per_item_per_merchant_standard_deviation
  @items.golden_items(std_dev)
  end

  def invoice(merchant_id)
    @invoices.find_all_by_merchant_id(merchant_id)
  end

  def merchant(id)
    @merchants.find_by_id(id)
  end

  def average_invoices_per_merchant
    ((@invoices.all.count).to_f / (@merchants.all.count).to_f).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    @invoices.average_invoices_per_merchant_standard_deviation
  end

end
