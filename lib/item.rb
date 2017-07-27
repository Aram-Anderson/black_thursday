require 'time'
require 'bigdecimal'

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
    @price        = BigDecimal.new(data[:unit_price])
    @unit_price   = unit_price_to_dollars(@price)
    @merchant_id  = data[:merchant_id]
    @created_at   = Time.parse(data[:created_at].to_s)
    @updated_at   = Time.parse(data[:updated_at].to_s)
    @item_repo    = item_repo
  end

  def unit_price_to_dollars(price)
    price / 100
  end

  def merchant
    @item_repo.merchant(merchant_id)
  end

end
