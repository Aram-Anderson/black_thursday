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

  def find_pending_invoices(hash_of_merchants_and_i_items)
    trans_results = []
    pending_invoices = []
    hash_of_merchants_and_i_items.each do |merchant_id, i_item_arr|
      i_item_arr.each do |i_item|
        transactions = find_all_by_invoice_id(i_item.invoice_id)
        transactions.each do |transaction|
           trans_results << transaction.result
          end
          pending_invoices = trans_results.all? |transaction|
            transaction.status == "failed" #returns true if all transactions are failed
        end
        [:merchant_id] = pending_invoices #not sure about syntax here, bc i think we're still in the loop for this merch_id key - at least, that's the idea
      end
      hash_of_merchants_and_pending_invoices = hash_of_merchants_and_invoices.each do |merch, pending|
        delete_if pending == false
      end
      hash_of_merchants_and_pending_invoices
    end

  end
