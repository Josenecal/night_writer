require 'CSV'

class Rosetta
  attr_reader :library
  def initialize (library)
    @library = library
  end

  def self.from_nightwriter
    table = CSV.read('./data/latin_to_braille.csv', headers: true, header_converters: :symbol)
    library = {}
    table.each { |line| library[line[:latin]] = line[:braille] }
    self.new(library)
  end

  def self.from_nightreader
    table = CSV.read('./data/latin_to_braille.csv', headers: true, header_converters: :symbol)
    library = {}
    table.each { |line| library[line[:braille]] = line[:latin] }
    self.new(library)
  end

  def translate (char)
    # Backlog - This REALLY shouldn't be hard coded
    return "......" if char == " "
    return " " if char == "......"
    @library[char]
  end

  def translate_line_latin_to_braille (input)
    translated_input = ["","",""]
      input.each_char { |char|
      translated_char = translate(char)
      translated_input[0] += translated_char[0] + translated_char[1]
      translated_input[1] += translated_char[2] + translated_char[3]
      translated_input[2] += translated_char[4] + translated_char[5] }
    translated_input[0] + "\n" + translated_input[1] + "\n" + translated_input[2] + "\n"
  end

  def translate_line_braille_to_latin (input)
    output = ""
    input.each {|char| output.concat(translate(char))}
    output
  end
end
