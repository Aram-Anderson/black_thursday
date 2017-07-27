module SalesAnalystMath

  def average_items_per_merchant_standard_deviation
    Math.sqrt(gets_sums_sqrt).round(2)
  end

  def gets_sums_sqrt
    summed = get_pre_sum_std_dev_array.sum
    divide_by = (get_pre_sum_std_dev_array.length) -1
    summed / divide_by
  end

  def get_pre_sum_std_dev_array
    mean = @sales_engine.average_items_per_merchant
    pre_sum_std_dev_array = gets_pre_anything_standard_deviation_array.map do |integer|
      (integer - mean) ** 2
    end
  end

  def gets_pre_anything_standard_deviation_array
    counts = Hash.new 0
    @items.each do |object|
      counts[object.merchant_id] += 1
    end
    counts.values
  end

end
