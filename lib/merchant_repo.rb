require_relative 'merchant'
require 'CSV'

class MerchantRepo

  attr_reader :merchants

  def initialize(file, sales_engine)
    @merchants = []
    @sales_engine = sales_engine
    create_merchants(file)
  end

  def create_merchants(file)
      CSV.foreach(file, :headers => true,
                        :header_converters => :symbol,
                        :converters =>
                        :all) do |row|
      @merchants <<  Merchant.new(row, self)
    end
  end

  def all
    @merchants
  end

  def find_by_id(id)
    @merchants.find { |object| object.id == id }
  end

  def find_by_name(name)
    @merchants.find {|object| object.name.downcase == name.downcase }
  end

  def find_all_by_name(frag)
    @merchants.find_all {|object| object.name.downcase.include? frag.downcase}
  end

  def item(merchant_id)
    @sales_engine.item(merchant_id)
  end

  def invoices(merchant_id)
    @sales_engine.invoice(merchant_id)
  end

  def get_high_achivers(count_hash)
    high_achiving_merchants = []
    mean = @sales_engine.average_items_per_merchant
    std_dev = @sales_engine.average_items_per_merchant_standard_deviation
    count_hash.each do |key, value|
      if value >= std_dev + mean
        high_achiving_merchants << key
      end
    end
    iterate_over_achivers(high_achiving_merchants)
  end

  def iterate_over_achivers(high_achiving_merchants)
    high_achiving_merchants.map do |merchant_id|
      find_by_id(merchant_id)
    end
  end

  def find_invoice_merchants(ids)
    ids.map do |id|
      find_by_id(id)
    end
  end
end
