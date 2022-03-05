class Document

  def initialize (input)
    @raw_text = input
    @parsed_text = []
  end

  def find_breaks
    output = []
    @raw_text.each_line { |line| output << line}
    @parsed_text = output
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

  def parse_latin
    find_breaks
    @parsed_text.map! { |line| line.length > 40 ? add_breaks(line) : line }
    @parsed_text.flatten!
    @parsed_text.map! do |line|
      line.chomp!
      line
    end
    @parsed_text
  end
end
