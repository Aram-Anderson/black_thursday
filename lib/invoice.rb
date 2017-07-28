require 'time'

class Invoice

  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at

  def initialize(data, invoice_repo)
    @invoice_repo = invoice_repo
    @id           = data[:id]
    @customer_id  = data[:customer_id]
    @merchant_id  = data[:merchant_id]
    @status       = data[:status]
    @created_at   = Time.parse(data[:created_at].to_s)
    @updated_at   = Time.parse(data[:updated_at].to_s)
  end

  def merchant
    @invoice_repo.merchant(merchant_id)
  end
end
