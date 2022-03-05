require 'rspec'
require 'lib/rosetta'

RSpec.describe Rosetta do

  it 'initializes with no arguments or readable attributes' do
    stone = Rosetta.new
    expect(stone).to be_a(Rosetta)
  end

end
