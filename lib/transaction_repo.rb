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

  end
