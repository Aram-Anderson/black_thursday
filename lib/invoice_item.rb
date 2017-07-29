require 'time'
require 'bigdecimal'

class InvoiceItem

  attr_reader :id,
              :item_id,
              :invoice_id

  def initialize(data)
    @id           = data[:id]
    @item_id      = data[:item_id]
    @invoice_id   = data[:invoice_id]
    @price        = BigDecimal.new(data[:unit_price])
    @unit_price   = unit_price_to_dollars(@price)
    @quantity     = data[:quantity]
    @created_at   = Time.parse(data[:created_at])
    @updated_at   = Time.parse(data[:updated_at])
  end

  def unit_price_to_dollars(price)
    price / 100
  end

end
