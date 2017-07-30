require_relative 'item_repo'
require_relative 'merchant_repo'
require_relative 'invoice_repo'
require_relative 'item_repo'
require_relative 'merchant_repo'
require_relative 'invoice_item_repo'
require_relative 'customer_repo'
require_relative 'transaction_repo'
require 'pry'

class SalesEngine

  def self.from_csv(init_hash)
    sales_engine = SalesEngine.new(init_hash)
  end

  attr_reader :items,
              :merchants,
              :invoices,
              :invoice_items,
              :transactions,
              :customers

  def initialize(init_hash)
    @merchants = MerchantRepo.new(init_hash[:merchants], self)
    @items     = ItemRepo.new(init_hash[:items], self)
    @invoices  = InvoiceRepo.new(init_hash[:invoices], self)
    @invoice_items = InvoiceItemRepo.new(init_hash[:invoice_items], self)
    @transactions = TransactionRepo.new(init_hash[:transactions], self)
    @customers = CustomerRepo.new(init_hash[:customers], self)

  end

  def item(id)
    @items.find_all_by_merchant_id(id)
  end

  def find_multiple_item_ids(item_ids)
    @items.find_multiple_item_ids(item_ids)
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

  def find_items_by_invoice_id(invoice_id)
     @invoice_items.find_all_items_by_invoice_id(invoice_id)
  end

  def find_transactions_by_invoice_id(invoice_id)
    @transactions.find_all_by_invoice_id(invoice_id)
  end

  def find_customer_from_invoice(id)
    @customers.find_by_id(id)
  end

  def get_invoice_from_transaction(invoice_id)
    @invoices.find_by_id(invoice_id)
  end

  def find_all_customers_for_merchant(merchant_id)
    @invoices.find_all_customers_for_merchant(merchant_id)
  end

  def find_multiple_customers(customer_ids)
    @customers.find_multiple_customers(customer_ids)
  end

 def find_all_merchants_for_customer(customer_id)
   @invoices.find_all_merchants_for_customer(customer_id)
 end

 def find_multiple_merchants(merchant_ids)
   @merchants.find_multiple_merchants(merchant_ids)
 end

end
