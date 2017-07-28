require_relative 'invoice'

class InvoiceRepo

  attr_reader :invoices

  def initialize(data, sales_engine)
    @sales_engine = sales_engine
    @invoices = []
    create_invoices(data)
  end

  def create_invoices(data)
      CSV.foreach(data, :headers => true,
                        :header_converters => :symbol,
                        :converters =>
                        :all) do |row|
      @invoices <<  Invoice.new(row, self)
    end
  end

  def all
    @invoices
  end

  def find_by_id(id)
    invoices.find {|invoice| invoice.id == id}
  end

  def find_all_by_customer_id(id)
    @invoices.find_all do |invoice|
      invoice.customer_id == id
    end
  end

  def find_all_by_merchant_id(id)
    @invoices.find_all do |invoice|
      invoice.merchant_id == id
    end
  end

  def find_all_by_status(status)
    @invoices.find_all do |invoice|
      invoice.status == status
    end
  end

  def merchant(merchant_id)
    @sales_engine.merchant(merchant_id)
  end
end
