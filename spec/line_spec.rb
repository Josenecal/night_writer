require 'rspec'
require './lib/line'

RSpec.describe Line do

  before :each do
    @line = Line.new("the quick brown fox jumped over the lazy brown dog")
  end

  it 'initializes with a single argument (not accessable) and an empty readable output attribute' do
    expect(@line).to be_a(Line)
    expect(@line.translated).to eq("")
  end

  it 'translates a line of text to three lines of braille' do
    expect(@line.translate.length).to eq(302) #account for two new line chars
    expect(@line.translate[0..5]).to eq(".oo.o.") # top dots of "the"
    expect(@line.translate[-6..-1]).to eq("..o...")# bottom dots of "dog"
  end

  end

end
