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

  def invoice_status(symbol)
    @engine.invoice_status(symbol)
  end

  def total_revenue_by_date(date)
    @engine.total_revenue_by_date(date)
  end

  def top_revenue_earners(num = 20)
    @engine.top_revenue_earners(num)
  end

  def merchants_with_pending_invoices
    @engine.merchants_with_pending_invoices
  end

  def merchants_ranked_by_revenue
    @engine.merchants_ranked_by_revenue
  end

  def revenue_by_merchant(merchant_id)
    @engine.revenue_by_merchant(merchant_id)
  end

  def best_item_for_merchant(merch_id)
    @engine.best_item_for_merchant(merch_id)
  end

  def merchants_with_only_one_item
    @engine.merchants_with_only_one_item
  end

  def merchants_with_only_one_item_registered_in_month(month)
    @engine.merchants_with_only_one_item_registered_in_month(month)
  end

  def most_sold_item_for_merchant(merchant_id)
    @engine.most_sold_item_for_merchant(merchant_id)
  end

end
