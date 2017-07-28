

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
end
