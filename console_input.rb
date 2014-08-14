require 'active_support'
require_relative 'tax_calculator.rb'
require_relative 'detail_generator.rb'
require_relative 'generate_output.rb'

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
    print_values_on_terminal
    print_as_file
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

    def print_values_on_terminal
      @output_hash.each do |key, value|
        display_cost = convert_to_currency( value["cost"] )
        puts "#{value["name"]}  : #{display_cost}"
      end
      display_total_cost = convert_to_currency( @total_hash["total_cost"] )
      display_total_taxes = convert_to_currency( @total_hash["total_taxes"] )
      puts "Total: #{display_total_cost} (including #{display_total_taxes} in taxes)"
    end

    def print_as_file
      
      display_output_hash = @output_hash
      display_total_hash = @total_hash
      display_output_hash.each do |key, value|
        value["cost"] = convert_to_currency( value["cost"] )
      end
      puts display_output_hash
      display_total_hash["total_cost"] = convert_to_currency( display_total_hash["total_cost"] )
      display_total_hash["total_taxes"] = convert_to_currency( display_total_hash["total_taxes"] )

      receipt = [display_output_hash, display_total_hash]

      GenerateOutput.new.execute(receipt)
    end

    def convert_to_currency value
      ActiveSupport::NumberHelper.number_to_currency(value.to_f/100)
    end
end