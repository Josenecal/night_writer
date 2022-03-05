require 'rspec'
require './lib/line'

RSpec.describe Line do

  before :each do
    @line = Line.new("the quick brown fox jumped over the lazy brown dog")
  end

  it 'initializes with a single argument and no accessible attributes' do
    expect(@line).to be_a(Line)
  end

  it 'translates a line of text to three lines of braille' do
    expect(@line.translate.length).to eq(303) #account for three new line chars
    expect(@line.translate[0..5]).to eq(".oo.o.") # top dots of "the"
    expect(@line.translate[-7..-1]).to eq("..o...\n")# bottom dots of "dog"
  end

end
