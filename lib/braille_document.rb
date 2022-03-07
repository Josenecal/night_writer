require_relative './rosetta'

class BrailleDocument

  def initialize (input)
    @input = input
    @rosetta = Rosetta.from_nightreader
  end

  def parse_lines
    output = []
    @input.each_line { |line| output << line.chomp }
    output
  end

  def group_lines (input)
    output = []
    while input.length > 0
      accumulator = []
      3.times { accumulator << input.shift }
      output << accumulator
    end
    output
  end

end
