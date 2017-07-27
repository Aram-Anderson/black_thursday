require_relative 'sales_analyst_math'

class SalesAnalyst
  include SalesAnalystMath

  def initialize(engine)
    @engine = engine
  end

  def average_items_per_merchant
    @engine.average_items_per_merchant
  end

  def average_items_per_merchant_standard_deviation
    @engine.average_items_per_merchant_standard_deviation
  end
end
