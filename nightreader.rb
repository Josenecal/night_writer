require_relative './lib/braille_document.rb'

input = File.open(ARGV[0])
document = BrailleDocument.new(input.read)
# require 'pry'; binding.pry
translated_text = document.get_translation
output = File.open(ARGV[1], "w")
output.write(translated_text)
puts "Created '#{ARGV[1]}' containing #{document.length} characters"
input.close
output.close
