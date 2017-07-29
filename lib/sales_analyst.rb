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

  def average_invoices_per_merchant
    @engine.average_invoices_per_merchant
  end

  def average_invoices_per_merchant_standard_deviation
    @engine.average_invoices_per_merchant_standard_deviation
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

  def top_merchants_by_invoice_count
    @engine.top_merchants_by_invoice_count
  end

  def bottom_merchants_by_invoice_count
    @engine.bottom_merchants_by_invoice_count
  end

  def top_days_by_invoice_count
    @engine.top_days_by_invoice_count
  end

end
