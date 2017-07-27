# require 'simplecov'
# SimpleCov.start

class Merchant

  attr_reader :id,
              :name,
              :created_at,
              :updated_at

  def initialize(data, merchants)
    @id         = data[:id]
    @name       = data[:name]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
    @merchant_repo = merchants
  end

  def items(merchant_id = @id)
    @merchant_repo.item(merchant_id)
  end


end
