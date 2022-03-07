require_relative './rosetta'

class BrailleDocument

  def initialize (input)
    @input = input
    @rosetta = Rosetta.from_nightreader
  end

end
