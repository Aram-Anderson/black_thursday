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

  def average_invoices_per_merchant_standard_deviation
    Math.sqrt(gets_sums_sqrt).round(2)
  end

  def gets_sums_sqrt
    summed = get_pre_sum_std_dev_array.sum
    divide_by = (get_pre_sum_std_dev_array.length) -1
    summed / divide_by
  end

  def get_pre_sum_std_dev_array
    mean = @sales_engine.average_invoices_per_merchant
    pre_sum_std_dev_array = gets_pre_anything_standard_deviation_array.map do |integer|
      (integer - mean) ** 2
    end
  end

  def gets_pre_anything_standard_deviation_array
    counts = Hash.new 0
    @invoices.each do |object|
      counts[object.merchant_id] += 1
    end
    counts.values
  end
end
