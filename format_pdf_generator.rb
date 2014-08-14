require 'prawn'

class PdfDetailGenerator < DetailGenerator

  @@extension = {"file_ext"=>"pdf", "display_type"=>"PDF"}

  def self.respond_to format
    format == @@extension["display_type"]
  end

  def self.display
    @@extension["display_type"]
  end

  def export
    pdf_file = get_file_name @@extension["file_ext"]

    pdf = Prawn::Document.new
    
    pdf.text "Shopping Receipt!!"
    pdf.text "Current Time: #{Time.now}"

    output_hash = receipt[0]
    total_hash = receipt[1]

    output_hash.each do |key, val|
      pdf.text("#{val["name"]} : #{val["cost"]}")
    end
    pdf.text("Total: #{total_hash["total_cost"]} (including #{total_hash["total_taxes"]})")
    pdf.render_file pdf_file
  end
end