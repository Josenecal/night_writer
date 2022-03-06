require_relative './line.rb'
class Document

  def initialize (input)
    @raw_text = input
    @parsed_lines = []
  end

  def find_breaks
    output = []
    @raw_text.each_line { |line| output << line}
    @parsed_lines = output
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

  def translate
    parse_lines
    # require 'pry';binding.pry
    result = ""
     @parsed_lines.map! {|line| Line.new(line)}
     @parsed_lines.each do |line|
      translated_line = line.translate
      # require 'pry';binding.pry
      result += translated_line
    end
    # require 'pry'; binding.pry
    result
  end
end
