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

  def is_it_paid_in_full?(invoice_id)
    trans = get_transactions(invoice_id)
    trans.any? do |tran|
      tran.result == "success"
    end
  end

  def get_transactions(invoice_id)
   @transactions.find_all_by_invoice_id(invoice_id)
  end

  def get_total_for_invoice(invoice_id)
    i_items = get_invoice_items(invoice_id)
    i_items.map do |i_item|
      i_item.unit_price * i_item.quantity
    end.inject(:+)
  end

  def get_invoice_items(invoice_id)
    all_invoice_items = @invoice_items.find_all_by_invoice_id(invoice_id)
    remove_unpaid_invoice_items(all_invoice_items)
  end

  def remove_unpaid_invoice_items(all_invoice_items)
    paid_i_items = []
    all_invoice_items.flatten.each do |i_item|
      if is_it_paid_in_full?(i_item.invoice_id)
        paid_i_items << i_item
      end
    end
    paid_i_items
  end

  def total_revenue_by_date(date)
    @invoices.total_revenue_by_date(date)
  end

  def invoices_for_total_revenue_by_date(invoice_array)
    @invoice_items.total_revenue_by_date(invoice_array)
  end

  def top_revenue_earners(num)
    merchant_ids = @merchants.get_all_merchant_ids
    hash_of_merchants_and_invoices =
    @invoices.get_hash_of_invoice_ids(merchant_ids)
    hash_of_invoice_items =
    @invoice_items.get_hash_of_all_invoice_items(hash_of_merchants_and_invoices)
    hash_of_invoice_items.each do |merchant_id, invoice_item_array|
      hash_of_invoice_items[merchant_id] =
      remove_unpaid_invoice_items(invoice_item_array)
    end
    hash_of_invoice_items.each do |merchant_id, invoice_item_array|
      prices = []
      invoice_item_array.each do |invoice_item|
        prices << invoice_item.unit_price * invoice_item.quantity
      end
      prices.flatten!
      hash_of_invoice_items[merchant_id] = prices.inject(:+)
    end
    hash_of_invoice_items.delete_if {|key, value| value.nil?}
    sorted_hash = hash_of_invoice_items.sort_by {|key, value| value}.reverse
    merchs_to_find = sorted_hash.shift(num)
    merch_ids_to_pass = merchs_to_find.map {|merch| merch[0]}
    @merchants.find_invoice_merchants(merch_ids_to_pass)
  end

  def merchants_with_pending_invoices

    merchant_ids = @merchants.get_all_merchant_ids
    @invoices.merchants_with_pending_invoices(merchant_ids)

    # hash_of_merchants_and_invoice_ids =
    # @invoices.get_hash_of_invoice_ids(merchant_ids)

    # hash_of_merchants_and_i_items = @invoice_items.get_hash_of_all_invoice_items(hash_of_merchants_and_invoices)

    # hash_of_merchants_and_pending_invoices = @transactions.find_pending_invoices(  hash_of_merchants_and_invoice_ids)
    #
    # merchants_with_pending_invoices = []
    # hash_of_merchants_and_pending_invoices.each_key do |merch_id|
    #  merchant = @merchants.find_by_id(merch_id)
    #   merchants_with_pending_invoices << merchant
    # end
    #  merchants_with_pending_invoices
  end

end
