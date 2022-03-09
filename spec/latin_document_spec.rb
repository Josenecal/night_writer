require './lib/latin_document'
require 'SimpleCov'
SimpleCov.start

RSpec.describe LatinDocument do

  before :each do
    @document = LatinDocument.new("the quick red fox jumped over the lazy brown dog")
  end

  it "initializes" do
    expect(@document).to be_a(LatinDocument)
  end

  it "scans for existing line breaks and reformats as arrays of paragraphs" do
    expected = @document.find_breaks
    expect(expected).to eq(["the quick red fox jumped over the lazy brown dog"])
    with_breaks = LatinDocument.new("the quick red fox jumped over the lazy brown dog\n\nthe lazy brown dog chased that fox all the way back to his den")
    expected = with_breaks.find_breaks
    expect(expected).to eq(["the quick red fox jumped over the lazy brown dog\n", "\n", "the lazy brown dog chased that fox all the way back to his den"])
  end

  it "Finds most appropriate break point in a  line of text" do
    expected = @document.add_breaks("the quick red fox jumped over the lazy brown dog and the lazy brown dog chased that fox all the way back to his den")

    expect(expected).to eq(["the quick red fox jumped over the lazy", "brown dog and the lazy brown dog chased", "that fox all the way back to his den"])
  end

  it "breaks down several paragraphs into lines preserving paragraph breaks" do
    document = LatinDocument.new "This is an example of a long paragraph. I'm writing this specifically so that the first paragraph will need to be broken into several lines, and so that the last line will hopefully be left kind of stubby\n\nThis is the beginning of a second paragraph. I'm realizing that this test is long enough!"
    expected = document.parse_lines
    expect(expected).to eq(["This is an example of a long paragraph.", "I'm writing this specifically so that", "the first paragraph will need to be", "broken into several lines, and so that", "the last line will hopefully be left", "kind of stubby", "", "This is the beginning of a second", "paragraph. I'm realizing that this test", "is long enough!"])
  end

  it "translates latin to braille" do
    expected = @document.get_translation
    expect(expected).to eq(".oo.o...ooo..oooo...o.o.oo..ooo.oo...oo.ooooo.oo..o.o.o.o....oo.o...o.o.o.oo\noooo.o..oo..o.......oo.o.o..o..o....oo....o..o.o...oo..ooo..oooo.o..o....o.o\no.......o.oo....o...o.........o.oo....ooo.o.......o.oo..o...o.......o...oooo\no.o.o..ooo..ooo.oo\no.oo.ooo.o...o.ooo\n..o.o..oo.....o...\n")
  end

  it "calculates output length" do
    expect(@document.length).to eq(47) # -1 space when line break is added
  end

  it "breaks words longer than 40 characters onto two lines" do
    doc = LatinDocument.new("pneumonoultramicroscopicsilicovolcanoconiosis")
    expected = doc.get_translation
    expect(expected.lines[0].length).to eq(81)
    expect(expected.lines[3].length).to eq(11)
  end

  it "keeps existing multiple line breaks" do
    doc = LatinDocument.new("this test has\n\ntwo paragraphs")
    expected = doc.get_translation

    expect(expected.lines.length).to eq(9)
    expect(expected.lines[4]).to eq("\n")
  end

  it "keeps existing multiple spaces" do
    doc = LatinDocument.new("so many             spaces")
    expected = doc.get_translation

    expect(expected.lines[0].length).to eq(53)
    expect(expected.lines[0][14..39]).to eq("..........................")
  end

end
