require 'CSV'


class MerchantRepo

  attr_reader :merchants

  def initialize(file)
    @merchants = []
  end

  def create_items(file)
      CSV.foreach(file, :headers => true, :header_converters => :symbol, :converters => :all) do |row|
      items <<  Merchant.new(row)
    end
  end  
end
