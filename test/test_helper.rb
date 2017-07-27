require 'simplecov'
SimpleCov.start do
  add_filter 'test/'
end

require './test/item_repo_test'
require './test/item_test'
require './test/merchant_repo_test'
require './test/merchant_test'
require './test/sales_engine_test'
require './test/sales_analyst_test'
