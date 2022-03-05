class Document

  def initialize (input)
    @raw_text = input
  end

  def find_breaks
    output = []
    @raw_text.each_line { |line| output << line}
    output
  end

  def add_breaks (line)
    output = []
    while (line.length > 40)
      nonsense = line.slice!(0..40)
      readable = nonsense.rpartition(" ")
      output << readable[0]
      line.prepend(readable[2])
    end
    output << line
  end
end
