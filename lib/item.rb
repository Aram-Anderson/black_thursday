require 'simplecov'
SimpleCov.start

class Item

  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at

  def initialize(data, item_repo)
    @id           = data[:id]
    @name         = data[:name]
    @description  = data[:description]
    @unit_price   = data[:unit_price]
    @merchant_id  = data[:merchant_id]
    @created_at   = data[:created_at]
    @updated_at   = data[:updated_at]
    @item_repo    = item_repo
  end

  def unit_price_to_dollars
    @unit_price.to_f / 100
  end

  def merchant(merchant_id = @merchant_id)
    binding.pry
    @item_repo.merchant(merchant_id)
  end

end
