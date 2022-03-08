require_relative './rosetta.rb'
class LatinDocument

  def initialize (input)
    @raw_text = input
    @parsed_lines = []
    @rosetta = Rosetta.from_nightwriter
  end

  def find_breaks
    output = []
    @raw_text.each_line { |line| output << line}
    @parsed_lines = output
  end

  def add_breaks (line)
    output = []
    while (line.length > 40)
      nonsense = line.slice!(0..39)
      if !nonsense.include?(" ") #to tolerate words long than 40 chars
        output << nonsense
        next
      end
      readable = nonsense.rpartition(" ")
      output << readable[0]
      line.prepend(readable[2])
    end
    output << line
  end

  def parse_lines
    find_breaks
    @parsed_lines.map! { |line| line.length > 40 ? add_breaks(line) : line }
    @parsed_lines.flatten!
    @parsed_lines.map! do |line|
      line.chomp!
      line
    end
    @parsed_lines
  end

  def get_translation
    parse_lines
    result = ""
     @parsed_lines.each do |line|
      translated_line = @rosetta.translate_line_latin_to_braille(line)
      result += translated_line
    end
    result
  end

  def length
    text = get_translation
    count = 0
    text.each_line {|line| count += line.chomp.length}
    output = count / 6
  end

end
