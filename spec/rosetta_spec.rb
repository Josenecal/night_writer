require 'rspec'
require 'CSV'
require './lib/rosetta.rb'

RSpec.describe 'Rosetta' do

  before :each do
    @stone = Rosetta.from_nightwriter
  end

  it 'initializes with no arguments or readable attributes' do
    expect(@stone).to be_a(Rosetta)
  end

  it "returns a linear braille translation of a lowercase latin letter" do
    expect(@stone.translate("a").to eq("..o..."))
    expect(@stone.translate("j").to eq(".o.oo."))
  end

end
