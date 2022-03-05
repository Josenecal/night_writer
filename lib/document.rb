class Document

  def initialize (input)
    @raw_text = input
  end

  def find_breaks
    output = []
    @raw_text.each_line { |line| output << line}
    output
  end

  def add_breaks ()

  end
end
