require_relative '../lib/rosetta'
require_relative '../lib/braille_document'
require 'RSpec'
require 'SimpleCov'
SimpleCov.start

RSpec.describe BrailleDocument do

  before :each do
    @doc = BrailleDocument.new(".oo.o...ooo..oooo...o.o.oo..ooo.oo...oo.ooooo.oo..o.o.o.o....oo.o...o.o.o.oo\noooo.o..oo..o.......oo.o.o..o..o....oo....o..o.o...oo..ooo..oooo.o..o....o.o\no.......o.oo....o...o.........o.oo....ooo.o.......o.oo..o...o.......o...oooo\no.o.o..ooo..ooo.oo\no.oo.ooo.o...o.ooo\n..o.o..oo.....o...\n")
  end

  it 'initializes' do
    expect(@doc).to be_a(BrailleDocument)
  end

  
end
