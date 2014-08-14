class GenerateOutput
  def execute receipt
    detail_generator_class = nil

    file_array = Dir["format_*.rb"]
    file_array.each {|current_file| require_relative("#{current_file}") }

    extension_array = DetailGenerator.descendants.map {|klass| klass.display }
    
    puts "Which format do you want your file in :"
    
    while detail_generator_class.nil?
      puts "Please note that available formats are (Enter the text exactly as displayed):"
      extension_array.each {|ext| puts "* #{ext}"}
      format_of_file = gets.chomp.to_s
      detail_generator_class = DetailGenerator.descendants.detect { |klass| klass.respond_to format_of_file }
    end

    detail_generator_class.new(receipt).export
  end
end