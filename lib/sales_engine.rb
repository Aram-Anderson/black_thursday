require './lib/item_repo'
require './lib/merchant_repo'
require 'pry'

class SalesEngine

def initialize
  @init_hash = init_hash
end

  def self.from_csv(init_hash={})
    @init_hash = init_hash
    ItemRepo.new(init_hash[:items])
    MerchantRepo.new(init_hash[:merchants])
  end



  # attr_reader :item_repo

  # def initialize
  #   @item_repo = ItemRepo.new
  #
  #   {:items     => "./data/items.csv",
  #   :merchants => "./data/merchants.csv",}
  # end




end
