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
      nonsense = line.slice!(0..40) # backlog - if we slice at the end of a word this may shorten a perfect 40 character line?
      readable = nonsense.rpartition(" ") #finds last instance of a space, returns three part array
      output << readable[0]
      line.prepend(readable[2]) #add back the beginning of whatever word we just cut in half with line.slice
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
     # @parsed_lines.map! {|line| Line.new(line)}
     @parsed_lines.each do |line|
      translated_line = @rosetta.translate_line_latin_to_braille(line)
      result += translated_line
    end
    result
  end
end
