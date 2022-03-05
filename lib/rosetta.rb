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
end
