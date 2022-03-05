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

  xit "parses paragraphs into lines of 40 characters or less" do
    expect(@document.parse).to eq(["The quick red fox jumped over the lazy", "brown dog"])
  end

end
