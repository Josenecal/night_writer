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

  xit "Finds most appropriate break point in a  line of text" do
    expected = @document.add_breaks("the quick red fox jumped over the lazy brown dog and the lazy brown dog chased that fox all the way back to his den")

    expect(expected).to
  end

  xit "parses paragraphs into lines of 40 characters or less" do
    expect(@document.parse).to eq(["The quick red fox jumped over the lazy", "brown dog"])
  end

end
