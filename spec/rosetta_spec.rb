require 'rspec'
require 'CSV'
require 'SimpleCov'
require './lib/rosetta.rb'
SimpleCov.start

RSpec.describe 'Rosetta' do

  context "::from_nightwriter" do

    before :each do
      @stone = Rosetta.from_nightwriter
    end

    it 'initializes with no arguments or readable attributes' do
      expect(@stone).to be_a(Rosetta)
    end

    it "returns a linear braille translation of a lowercase latin letter" do
      expect(@stone.translate("a")).to eq("o.....")
      expect(@stone.translate("j")).to eq(".ooo..")
    end

    it 'translates a line of text to three lines of braille' do
      expected = @stone.translate_line_latin_to_braille("the quick brown fox jumped over the lazy brown dog")
      expect(expected.length).to eq(303) #account for three new line chars
      expect(expected[0..5]).to eq(".oo.o.") # top dots of "the"
      expect(expected[-7..-1]).to eq("..o...\n")# bottom dots of "dog"
    end
  end

  context "::from_nightreader" do

    before :each do
      @rock = Rosetta.from_nightreader
    end

    it 'initializes' do
      expect(@rock).to be_a(Rosetta)
    end

    it "translates chars braille to latin" do
      expect(@rock.translate("o.....")).to eq("a")
      expect(@rock.translate(".ooo..")).to eq("j")
    end

    it "translates an array of braille character strings to a string of latin" do
      braille = [".oooo.", "o.oo..", "o..o..", "......", "ooooo.","o...oo", ".oo...", "oo....", "o...o."]
      expected = @rock.translate_line_braille_to_latin(braille)

      expect(expected).to eq("the quick")
    end
  end
end
