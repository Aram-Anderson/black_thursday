require_relative 'item_repo'
require_relative 'merchant_repo'
require_relative 'invoice_repo'
require_relative 'item_repo'
require_relative 'merchant_repo'
require 'pry'

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

  def item(id)
    @items.find_all_by_merchant_id(id)
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
    @items.average_item_price_for_merchant(merchant_id)
  end

  def average_average_price_per_merchant
    merchs = @merchants.all.map do |merch|
              merch.id
            end
    @items.average_average_price_per_merchant(merchs)
  end

  def golden_items
    @items.golden_items
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

  def top_merchants_by_invoice_count
    @invoices.top_merchants_by_invoice_count
  end

  def bottom_merchants_by_invoice_count
    @invoices.bottom_merchants_by_invoice_count
  end

  def find_invoice_merchants(ids)
    @merchants.find_invoice_merchants(ids)
  end

  def top_days_by_invoice_count
    @invoices.top_days_by_invoice_count
  end

  def invoice_status(symbol)
    @invoices.invoice_status(symbol)
  end

end
