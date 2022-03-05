require './rosetta'
class Line

  def initialize (input)
    @input = input
    @rosetta = Rosetta.from_nightwriter #refactor for nightreader, holding instance as attribute to avoid redundant loading of instnaces
  end

  def translate
    translated_input = ["","",""]
    @input.each_char do |char|
      translated_char = @rosetta.translate(char)
      translated_input[0] += translated_char[2] + translated_char[3]
      translated_input[1] += translated_char[1] + translated_char[4]
      translated_input[2] += translated_char[0] + translated_char[5]
    end
    translated_input.map! {|line| line += "\n"}
    translated_input[0] + translated_input[1] + translated_input[2]
  end

end
