require_relative '../lib/rosetta'
require_relative '../lib/braille_document'
require 'RSpec'
require 'SimpleCov'
SimpleCov.start

RSpec.describe BrailleDocument do

  before :each do
    @doc = BrailleDocument.new(".oo.o...ooo..oooo...o.o.oo..ooo.oo...oo.ooooo.oo..o.o.o.o....oo.o...o.o.o.oo\noooo.o..oo..o.......oo.o.o..o..o....oo....o..o.o...oo..ooo..oooo.o..o....o.o\no.......o.oo....o...o.........o.oo....ooo.o.......o.oo..o...o.......o...oooo\no.o.o..ooo..ooo.oo\no.oo.ooo.o...o.ooo\n..o.o..oo.....o...\n")
  end

  it 'initialize' do
    expect(@doc).to be_a(BrailleDocument)
  end

  it 'returns output length less non-printing characters' do
    expect(@doc.length).to eq(47)
  end

  it 'parse brail document into lines' do
    expected = @doc.parse_lines
    expect(expected).to eq([".oo.o...ooo..oooo...o.o.oo..ooo.oo...oo.ooooo.oo..o.o.o.o....oo.o...o.o.o.oo", "oooo.o..oo..o.......oo.o.o..o..o....oo....o..o.o...oo..ooo..oooo.o..o....o.o", "o.......o.oo....o...o.........o.oo....ooo.o.......o.oo..o...o.......o...oooo", "o.o.o..ooo..ooo.oo", "o.oo.ooo.o...o.ooo", "..o.o..oo.....o..."])
  end

  it 'group lines of three together in subarrays' do
    input = @doc.parse_lines
    expected = @doc.group_lines(input)

    expect(expected).to eq([[".oo.o...ooo..oooo...o.o.oo..ooo.oo...oo.ooooo.oo..o.o.o.o....oo.o...o.o.o.oo", "oooo.o..oo..o.......oo.o.o..o..o....oo....o..o.o...oo..ooo..oooo.o..o....o.o", "o.......o.oo....o...o.........o.oo....ooo.o.......o.oo..o...o.......o...oooo"], ["o.o.o..ooo..ooo.oo", "o.oo.ooo.o...o.ooo", "..o.o..oo.....o..."]])
  end

  it "turn all line trios into character subarrays" do
    expected = @doc.build_chars([["o.o.o.o....oo.o...o.o.o.oo", ".oo..ooo..oooo.o..o....o.o", "o.oo..o...o.......o...oooo"], ["o.o.o..ooo..ooo.oo", "o.oo.ooo.o...o.ooo", "..o.o..oo.....o..."]])

    expect(expected).to eq([["o..oo.", "o.o.oo", "o..o..", "o.ooo.", "......", ".oooo.", "o.oo..", "o..o..", "......", "o.o.o.", "o.....", "o..ooo", "oo.ooo" ],["o.o...", "o.ooo.", "o..oo.", ".ooo.o", "oo.oo.", "......", "oo.o..","o..oo.", "oooo.."]])
  end

  it 'turn a single line trio subarray into braille character subarrays' do
    expected = @doc.trio_deconstructor(["o.o.o..ooo..ooo.oo", "o.oo.ooo.o...o.ooo", "..o.o..oo.....o..."])

    expect(expected).to eq(["o.o...", "o.ooo.", "o..oo.", ".ooo.o", "oo.oo.", "......", "oo.o..","o..oo.", "oooo.."])
  end

  it 'translates a formatted input' do
    expected = @doc.translate([["o..oo.", "o.o.oo", "o..o..", "o.ooo.", "......", ".oooo.", "o.oo..", "o..o..", "......", "o.o.o.", "o.....", "o..ooo", "oo.ooo" ],["o.o...", "o.ooo.", "o..oo.", ".ooo.o", "oo.oo.", "......", "oo.o..","o..oo.", "oooo.."]])

    expect(expected).to eq("over the lazy\nbrown dog\n")
  end

  it 'translates the entire document' do
    expected = @doc.get_translation

    expect(expected).to eq("the quick red fox jumped over the lazy\nbrown dog")
  end
end
