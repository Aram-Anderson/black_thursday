class Merchant

  attr_reader :id,
              :name,
              :created_at,
              :updated_at,
              :merchant_id

  def initialize(data, merchants)
    @id         = data[:id]
    @name       = data[:name]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
    @merchant_repo = merchants
  end

  def items
    @merchant_repo.item(merchant_id)
  end

  def invoices
    @merchant_repo.invoices(id)
  end


end
