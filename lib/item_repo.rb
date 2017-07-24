require 'CSV'

class ItemRepo

  attr_reader :items

  def initialize
    @items = []
    # create_items(file)
  end

  def create_items(file)
      CSV.foreach(file, :headers => true, :header_converters => :symbol, :converters => :all) do |row|
      items <<  Item.new(row)
      end
  end

end
