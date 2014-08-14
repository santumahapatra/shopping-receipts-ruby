require 'active_support/inflector'

class TaxCalculator
  attr_reader :quantity, :name, :imported, :price, :sales_tax_exempt
  I18n.enforce_available_locales = false

  @@exempt_items = {
    "book"=> "book",
    "chocolate bar"=> "food",
    "box of chocolate"=> "food",
    "packet of headache pill"=> "medical product"
  }

  def initialize input
    words = input.split(" ")
    length = words.length

    @name = words[0, length - 2].join(" ")
    @quantity = words[0]
    @price = (words[length - 1].to_f * 100).to_i

    if words.include? "imported"
      @imported = true
      words.delete "imported"
    else
      @imported = false
    end

    item = words[1, words.length - 3].map{|s| s.singularize}.join(" ")
    @sales_tax_exempt = check_exemption item
  end

  def output
    tax_amount = calculate_tax
    {
      "name" => @name,
      "cost" => @price + tax_amount,
      "taxes" => tax_amount
    }
  end

  private
    def calculate_tax
      round_off_to_5((( @price * tax_percentage) / 100 ).to_i)
    end

    def round_off_to_5 value
      remainder = value % 5
      if remainder <= 2
        value -= remainder
      else
        value += (5 - remainder)
      end
      value
    end

    def tax_percentage
      n = 0
      n += 5 if @imported
      n += 10 if !@sales_tax_exempt
      n
    end

    def check_exemption item
      @@exempt_items["#{item}"].nil? ? false : true
    end
end