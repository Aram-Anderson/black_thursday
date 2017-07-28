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

  def merchants_with_high_item_count
    @engine.merchants_with_high_item_count
  end

  def average_item_price_for_merchant(merchant_id)
    @engine.average_item_price_for_merchant(merchant_id)
  end

  def average_average_price_per_merchant
    @engine.average_average_price_per_merchant
  end

  def golden_items
    @engine.golden_items
  end

  
end
