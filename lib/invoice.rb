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
    @status       = data[:status].to_sym
    @created_at   = Time.parse(data[:created_at].to_s)
    @updated_at   = Time.parse(data[:updated_at].to_s)
  end

  def merchant
    @invoice_repo.merchant(merchant_id)
  end

  def items
    @invoice_repo.find_items_by_invoice_id(id)
  end
  def transactions
    @invoice_repo.find_transactions_by_invoice_id(id)
  end

  def customer
    @invoice_repo.find_customer_from_invoice(customer_id)
  end

end
