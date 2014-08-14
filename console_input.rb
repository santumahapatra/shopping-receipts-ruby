require_relative 'tax_calculator.rb'

class ConsoleInput
  attr_reader :input_hash, :output_hash, :total_hash

  def initialize
    @input_hash = {}
    @output_hash = {}
    @total_hash = {"total_cost" => 0, "total_taxes" => 0}
  end

  def execute
    take_input
    calculate_output
    calculate_total
    print_values
  end

  private

    def take_input
      index = 0
      input = gets.chomp.to_s
      while input && input != ""
        @input_hash["#{index}"] = input
        input = gets.chomp.to_s
        index += 1
      end
      @input_hash
    end

    def calculate_output
      @input_hash.each do |key, value|
        item_output = TaxCalculator.new(value).output
        @output_hash["#{key}"] = item_output
      end
    end

    def calculate_total
      @output_hash.each do |key, value|
        @total_hash["total_cost"] += value["cost"]
        @total_hash["total_taxes"] += value["taxes"]
      end
    end

    def print_values
      @output_hash.each do |key, value|
        puts "#{value["name"]}  : #{value["cost"]}"
      end
      puts "Total: #{@total_hash["total_cost"]} (including #{@total_hash["total_taxes"]} in taxes)"
    end
end