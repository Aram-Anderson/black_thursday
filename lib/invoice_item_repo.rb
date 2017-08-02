require 'csv'
require_relative 'invoice_item'
require 'pry'

class InvoiceItemRepo
  attr_reader :invoice_items

  def initialize(file, sales_engine)
    @sales_engine = sales_engine
    @invoice_items = []
    from_csv(file)
  end

  def from_csv(file)
    CSV.foreach(file, :headers => true,
                      :header_converters =>
                      :symbol,
                      :converters =>
                      :all) do |row|
    @invoice_items <<  InvoiceItem.new(row)
    end
  end

  def all
    @invoice_items
  end

  def find_by_id(id)
    @invoice_items.find {|item| item.id == id}
  end

  def find_all_by_item_id(item_id)
    @invoice_items.find_all {|item| item.item_id == item_id}
  end

  def find_all_by_invoice_id(invoice_id)
    @invoice_items.find_all {|item| item.invoice_id == invoice_id}
  end

  def find_all_items_by_invoice_id(invoice_id)
    found_item_ids = []
     @invoice_items.each do |invoice_item|
      if invoice_item.invoice_id == invoice_id
          found_item_ids << invoice_item.item_id
      end
    end
      @sales_engine.find_multiple_item_ids(found_item_ids)
  end

  def total_revenue_by_date(invoice_id_numbers)
    invoice_items_from_id = invoice_id_numbers.map do |invoice_id|
      find_all_by_invoice_id(invoice_id)
    end
    invoice_items_from_id
    invoice_items_from_id_valid =
    @sales_engine.remove_unpaid_invoice_items(invoice_items_from_id)
    sum_totals_from_invoice_items(invoice_items_from_id_valid)
  end

  def sum_totals_from_invoice_items(invoice_items_from_id_valid)
    total = invoice_items_from_id_valid.map do |i_item|
      i_item.unit_price * i_item.quantity
    end
    total.inject(:+)
  end

  def get_hash_of_all_invoice_items(hash_of_merchants_and_invoices)
    hash_of_merchants_and_invoices.each do |merchant, invoice_ids|
      invoice_items_by_invoice_id = []
      invoice_ids.each do |invoice_id|
      invoice_items_by_invoice_id  << find_all_by_invoice_id(invoice_id)
      end
    hash_of_merchants_and_invoices[merchant] =
    invoice_items_by_invoice_id.flatten
    end
  end

  def get_inv_items_from_invoice_ids(invoices_id_hash)
    invoices_id_hash.each do |k, v|
      i_item_array = []
      @invoice_items.each do |i_item|
        if i_item.invoice_id == k
          i_item_array << i_item
        end
      end
      invoices_id_hash[k] = i_item_array
    end
    create_new_hash_of_item_id_i_item(invoices_id_hash)
    # @sales_engine.all_item_i_items(item_id_hash)
  end

  def create_new_hash_of_item_id_i_item(invoices_id_hash)
    item_id_i_item_hash = Hash.new
    invoices_id_hash.each do |k, v|
      max_i_item = v.max_by {|i_item| i_item.quantity * i_item.unit_price}
      item_id_i_item_hash[max_i_item.item_id] = v
    end
    item_id_i_item_hash
  end

end
