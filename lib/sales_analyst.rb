

class SalesAnalyst


  def initialize(engine)
    @engine = engine
  end

  def average_items_per_merchant
    @engine.average_items_per_merchant
  end

  def average_items_per_merchant_standard_deviation
    @engine.average_items_per_merchant_standard_deviation
  end

  def merchants_with_highest_item_count
    @engine.merchants_with_highest_item_count
  end
end
