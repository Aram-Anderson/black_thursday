require './lib/item_repo'
require './lib/merchant_repo'
require 'pry'

class SalesEngine

  def self.from_csv(init_hash)
    sales_engine = SalesEngine.new(init_hash)
  end

  attr_reader :item_repo,
              :merchant_repo

  def initialize(init_hash)
    @merchant_repo = MerchantRepo.new(init_hash[:merchants], self)
    @item_repo     = ItemRepo.new(init_hash[:items], self)
  end

  def merchants
    merchant_repo.merchants
  end

  def items
    @item_repo.all
  end


end
