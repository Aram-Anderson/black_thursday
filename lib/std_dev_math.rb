module StdDevMath
  def standard_deviation(hash)
    array = hash.values
    Math.sqrt(gets_sums_sqrt(array)).round(2)
  end

  def gets_sums_sqrt(array)
    summed = get_pre_sum_std_dev_array(array).reduce(:+)
    divide_by = (get_pre_sum_std_dev_array(array).length) -1
    summed / divide_by
  end

  def get_pre_sum_std_dev_array(array)
    mean = array.inject(:+).to_f / array.length.to_f
    pre_sum_std_dev_array = array.map do |integer|
      (integer.to_f - mean) ** 2
    end
  end

end
