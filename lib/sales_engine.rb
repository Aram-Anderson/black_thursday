require './lib/item_repo'
require './lib/merchant_repo'
require 'pry'

class SalesEngine

  def self.from_csv(init_hash)
    sales_engine = SalesEngine.new(init_hash)
  end

  attr_reader :items,
              :merchants

  def initialize(init_hash)
    @merchants = MerchantRepo.new(init_hash[:merchants], self)
    @items     = ItemRepo.new(init_hash[:items], self)
  end

end
