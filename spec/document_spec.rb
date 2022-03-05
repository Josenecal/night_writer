require './lib/document'
require 'SimpleCov'
SimpleCov.start

RSpec.describe Document do

  before :each do
    @document = Document.new("the quick red fox jumped over the lazy brown dog")
  end

  it "initializes" do
    expect(@document).to be_a(Document)
  end

  it "scans for existing line breaks and reformats as arrays of paragraphs" do
    expected = @document.find_breaks
    expect(expected).to eq(["the quick red fox jumped over the lazy brown dog"])
    with_breaks = Document.new("the quick red fox jumped over the lazy brown dog\n\nthe lazy brown dog chased that fox all the way back to his den")
    expected = with_breaks.find_breaks
    expect(expected).to eq(["the quick red fox jumped over the lazy brown dog\n", "\n", "the lazy brown dog chased that fox all the way back to his den"])
  end

  it "Finds most appropriate break point in a  line of text" do
    expected = @document.add_breaks("the quick red fox jumped over the lazy brown dog and the lazy brown dog chased that fox all the way back to his den")

    expect(expected).to eq(["the quick red fox jumped over the lazy", "brown dog and the lazy brown dog chased", "that fox all the way back to his den"])
  end

  it "breaks down several paragraphs into lines preserving paragraph breaks" do
    document = Document.new "This is an example of a long paragraph. I'm writing this specifically so that the first paragraph will need to be broken into several lines, and so that the last line will hopefully be left kind of stubby\n\nThis is the beginning of a second paragraph. I'm realizing that this test is long enough!"
    expected = document.parse_latin
    expect(expected).to eq(["This is an example of a long paragraph.", "I'm writing this specifically so that", "the first paragraph will need to be", "broken into several lines, and so that", "the last line will hopefully be left", "kind of stubby", "", "This is the beginning of a second", "paragraph. I'm realizing that this test", "is long enough!"])
  end

  it "translates latin to braille" do
    expected = @document.translate
    expect(expected).to eq(".oo.o...ooo..oooo...o.o.o..ooo..ooo.oo...oo.ooooo.oo..o.o.o.o....oo.o...o.o.o.oo\noooo.o..oo..o.......o.oo.ooo.o..o..o....oo....o..o.o...oo..ooo..oooo.o..o....o.o\no.......o.oo....o.....o.o..oo.....o.oo....ooo.o.......o.oo..o...o.......o...oooo\no.o.o..ooo..ooo.oo\no.oo.ooo.o...o.ooo\n..o.o..oo.....o...")
  end

end
