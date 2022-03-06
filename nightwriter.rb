# Welcome to Night Writer! This program will generate simulted on-screen
# braile text (I know, ironic) from a given input txt file, and save those
# data to a newly-generated output file.

# To run Night Writer, enter the following command into the command line:

# $ ruby nightwriter.rb <input_file.txt> <output_file.txt>

# where <input_file.txt> represents either the relative or absolute
# filepath to your input file, and <output_file.txt> represents the
# relative or absolute path to the desired output file you would like
# nightwriter to generate.

# This code may be used freely under the creative commons license for personal,
# academic and other non-commercial uses with attribution.
require_relative './lib/document.rb'

input = File.open(ARGV[0])
document = Document.new(input.read)
# require 'pry'; binding.pry
translated_text = document.translate
output = File.open(ARGV[1], "w")
output.write(translated_text)
text_length = input.read.length
puts "Created '#{ARGV[1]}' containing #{text_length} characters"
input.close
output.close
