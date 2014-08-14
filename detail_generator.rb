class DetailGenerator
  attr_reader :receipt

  def initialize receipt
    @receipt = receipt
  end

  def self.descendants
    ObjectSpace.each_object(Class).select { |klass| klass < self }
  end

  def export receipt, format_of_file
    raise "Method not implemented"
  end

  def get_file_name file_ext
    "receipt_#{Time.now.to_i}.#{file_ext}"
  end
end