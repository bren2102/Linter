#!/usr/bin/env ruby
require './lib/compare.rb'

compare = Compare.new
file = File.open("doc.xml")
#file.foreach("doc.xml") { |line| puts line}

File.foreach("doc.xml").with_index do |line, line_num|
   puts "#{line_num}: #{line}"
   if compare.evaluate_line(line) == true
     compare.compare_same_tag(line)
   end
end

#file_data = file.readlines.map(&:chomp)
#puts file_data
file.close
