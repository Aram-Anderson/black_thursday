require './lib/merchant'
require 'CSV'


class MerchantRepo

  attr_reader :merchants

  def initialize(file, sales_engine)
    @merchants = []
    @sales_engine = sales_engine
    create_merchants(file)
  end

  def create_merchants(file)
      CSV.foreach(file, :headers => true, :header_converters => :symbol, :converters => :all) do |row|
      @merchants <<  Merchant.new(row)
    end
  end


end
