require 'rspec'
require './lib/line'

RSpec.describe Line do

  it 'initializes with a single argument (not accessable) and an empty readable output attribute' do
    line = Line.new("the quick brown fox jumped over the lazy brown dog")
    expect(line).to be_a(Line)
    expect(line.translated).to eq("")
  end 
end
