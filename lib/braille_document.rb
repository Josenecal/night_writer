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

  def trio_deconstructor (trio)
    output = []
    while trio[0].length > 0
      to_add = ""
      trio.each {|line| to_add.concat(line.slice!(0,2))}
      output << to_add
    end
    output
  end

  def build_chars (input)
    input.map { |trio| trio_deconstructor(trio) }
  end

  def translate (formatted_input)
    output = ""
    formatted_input.each { |line_array| output.concat(@rosetta.translate_line_braille_to_latin(line_array) + "\n")}
    output
  end

  # def get_translation
  #   parsed = parse_lines
  #   grouped = group_lines(parsed)
  #

end
