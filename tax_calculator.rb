class TaxCalculator
  attr_reader :quantity, :name, :imported, :price, :sales_tax_exempt

  def initialize input
    words = input.split(" ")
    length = words.length

    @name = words[0, length - 3].join(" ")
    @quantity = words[0]
    @price = (words[length - 1].to_f * 100).to_i

    if words[1] == "imported"
      @imported = true
      item = words[1, length - 3].join(" ")
    else
      @imported = false
      item = words[1, length - 3].join(" ")
    end

    @sales_tax_exempt = false
  end

  def output
    tax_amount = calculate_tax

    puts @price, tax_amount
    {
      "name" => @name,
      "cost" => @price + tax_amount,
      "taxes"  => tax_amount
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
end