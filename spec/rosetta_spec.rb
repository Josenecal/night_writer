require 'rspec'
require 'CSV'
require 'SimpleCov'
require './lib/rosetta.rb'
SimpleCov.start

RSpec.describe 'Rosetta' do

  before :each do
    @stone = Rosetta.from_nightwriter
  end

  it 'initializes with no arguments or readable attributes' do
    expect(@stone).to be_a(Rosetta)
  end

  it "returns a linear braille translation of a lowercase latin letter" do
    expect(@stone.translate("a")).to eq("o.....")
    expect(@stone.translate("j")).to eq(".ooo..")
  end

  it 'translates a line of text to three lines of braille' do
    expected = @stone.translate_line_latin_to_braille("the quick brown fox jumped over the lazy brown dog")
    expect(expected.length).to eq(303) #account for three new line chars
    expect(expected[0..5]).to eq(".oo.o.") # top dots of "the"
    expect(expected[-7..-1]).to eq("..o...\n")# bottom dots of "dog"
  end

end
