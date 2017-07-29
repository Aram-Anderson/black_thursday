require 'simplecov'
SimpleCov.start do
  add_filter 'test/'
end

require_relative 'item_repo_test'
require_relative 'item_test'
require_relative 'merchant_repo_test'
require_relative 'merchant_test'
require_relative 'sales_engine_test'
require_relative 'sales_analyst_test'
require_relative 'invoice_repo_test'
require_relative 'invoice_test'
require_relative 'invoice_item_repo_test'
require_relative 'invoice_item_test'
