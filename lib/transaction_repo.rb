require 'csv'
require_relative 'transaction'
require 'pry'
require 'bigdecimal'

class TransactionRepo
  attr_reader :transactions

  def initialize(file, sales_engine)
    @sales_engine = sales_engine
    @transactions = []
    from_csv(file)
  end

  def from_csv(file)
    CSV.foreach(file, :headers => true,
                      :header_converters =>
                      :symbol) do |row|
    @transactions << Transaction.new(row, self)
    end
  end

  def all
    @transactions
  end

  def find_by_id(id)
    @transactions.find {|trans| trans.id == id}
  end

  def find_all_by_invoice_id(invoice_id)
    @transactions.find_all {|trans| trans.invoice_id == invoice_id}
  end

  def find_all_by_credit_card_number(credit_card_number)
    @transactions.find_all do |trans|
      trans.credit_card_number == credit_card_number
    end
  end

  def find_all_by_result(result)
    @transactions.find_all {|trans| trans.result == result}
  end

  def get_invoice_from_transaction(invoice_id)
    @sales_engine.get_invoice_from_transaction(invoice_id)
  end

  def find_pending_invoices(hash_of_merchants_and_invoice_ids)
    find_pending_invoices_helper1(hash_of_merchants_and_invoice_ids)
  end


  #   def find_pending_invoices_helper1(hash_of_merchants_and_invoice_ids)
  #       hash_of_merchants_and_invoice_ids.each do |merchant_id, invoice_arr|
  #     transactions = []
  #     invoice_arr.each do |invoice_id|
  #       transactions <<  find_all_by_invoice_id(invoice_id)
  #     end
  #     binding.pry
  #     transactions.flatten.delete_if
  #     hash_of_merchants_and_invoice_ids[merchant_id] = transactions.flatten
  #   end
  #     hash_of_merchants_and_invoice_ids.each do |merch, trans|
  #       trans_results = []
  #       trans.each do |trans|
  #         trans_results << trans.result
  #       end
  #       hash_of_merchants_and_invoice_ids[merch] = trans_results.flatten
  #       hash_of_merchants_and_invoice_ids.delete_if {|k,v| v.all? == "success"}
  #     end
  #
  # end
  #
  # def find_pending_invoices_helper2(hash_of_merchants_and_transactions)
  #   hash_of_merchants_and_transactions.each do |merchant, transaction_arr|
  #     trans_results = []
  #     pending_invoices = []
  #     transaction_arr.each do |transaction|
  #       trans_results << transaction.result
  #     end
  #     pending_invoices = trans_results.any? {|transaction| transaction == "failed"}
  #     hash_of_merchants_and_transactions[merchant] = pending_invoices
  #   end
  #   binding.pry
  #     hash_of_merchants_and_pending_invoices = hash_of_merchants_and_invoices.each do |merch, pending|
  #       delete_if pending == false
  #     end
  #     hash_of_merchants_and_pending_invoices
  #   end


end
