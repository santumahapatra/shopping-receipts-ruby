require 'fileutils'

class TxtDetailGenerator < DetailGenerator

  @@extension = {"file_ext"=>"txt", "display_type"=>"plain text"}

  def self.respond_to format
    format == @@extension["display_type"]
  end

  def self.display
    @@extension["display_type"]
  end

  def export
    txt_file = get_file_name @@extension["file_ext"]

    FileUtils.touch txt_file

    File.open(txt_file, 'w') do |f|
      f.write "Shopping Receipt!!\n"
      f.write "Current Time: #{Time.now}\n\n"
      output_hash = receipt[0]
      total_hash = receipt[1]

      output_hash.each do |key, val|
        f.write("#{val["name"]} : #{val["cost"]}\n")
      end
      f.write("\nTotal: #{total_hash["total_cost"]} (including #{total_hash["total_taxes"]})\n")
    end
  end
end