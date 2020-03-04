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

  if line_num == 0
    compare.compare_first_line(line)
  end

  if compare.evaluate_multilineal_tag(line) == 1 
    compare.get_multilineal_initial_tag(line)
  elsif compare.evaluate_multilineal_tag(line) == 2
    compare.get_multilineal_lasting_tag(line)
  end

end

compare.compare_multilineal
#file_data = file.readlines.map(&:chomp)
#puts file_data
file.close
