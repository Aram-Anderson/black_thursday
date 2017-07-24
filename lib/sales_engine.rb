require './lib/item_repo'

class SalesEngine

  attr_reader :item_repo

  def initialize
    @item_repo = ItemRepo.new
  end
end
