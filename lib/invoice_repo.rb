require 'time'
require_relative 'day_of_week'
require_relative 'invoice'
require_relative 'std_dev_math'

class InvoiceRepo
  include StdDevMath
  include DayOfWeek

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

  def average_invoices_per_merchant
    @sales_engine.average_invoices_per_merchant
  end

  def average_invoices_per_merchant_standard_deviation
    counts = Hash.new 0
    @invoices.each do |object|
      counts[object.merchant_id] += 1
    end
    standard_deviation(counts)
  end

  def top_merchants_by_invoice_count
    count = Hash.new 0
    @invoices.each do |invoice|
      count[invoice.merchant_id] += 1
    end
    parse_out_high_performers(count)
  end

  def parse_out_high_performers(count)
    mean = average_invoices_per_merchant
    std_dev = standard_deviation(count)
    to_beat = (std_dev * 2) + mean
    ids = []
      count.each do |key, value|
        if value >= to_beat
          ids << key
        end
      end
    @sales_engine.find_invoice_merchants(ids)
  end

  def bottom_merchants_by_invoice_count
    count = Hash.new 0
    @invoices.each do |invoice|
      count[invoice.merchant_id] += 1
    end
    parse_out_low_performers(count)
  end

  def parse_out_low_performers(count)
    mean = average_invoices_per_merchant
    std_dev = standard_deviation(count)
    to_beat = mean - (std_dev * 2)
    ids = []
      count.each do |key, value|
        if value <= to_beat
          ids << key
        end
      end
    @sales_engine.find_invoice_merchants(ids)
  end

  def top_days_by_invoice_count
    count = Hash.new 0
    @invoices.each do |invoice|
      count[invoice.created_at.wday] += 1
    end
    parse_out_dates(count)
  end

  def parse_out_dates(count)
    mean = count.values.inject(:+) / count.length
    std_dev = standard_deviation(count)
    to_beat = std_dev + mean
    dates = []
      count.each do |key, value|
        if value > to_beat
          dates << key
        end
      end
    what_day_is_it?(dates)
  end

  def invoice_status(symbol)
    total = @invoices.count
    count = Hash.new 0
    @invoices.each do |invoice|
      count[invoice.status] += 1
    end
    ((count[symbol].to_f / total) * 100).round(2)
  end

  def find_items_by_invoice_id(invoice_id)
    @sales_engine.find_items_by_invoice_id(invoice_id)
  end

  def find_transactions_by_invoice_id(invoice_id)
    @sales_engine.find_transactions_by_invoice_id(invoice_id)
  end

end
