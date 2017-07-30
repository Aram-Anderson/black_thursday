require 'csv'
require_relative 'invoice_item'

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
      @sales_engine.find_multiple_item_ids(found_item_ids)
    end
  end


end
