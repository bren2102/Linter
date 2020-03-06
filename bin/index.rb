#!/usr/bin/env ruby
require_relative '../lib/compare.rb'

compare = Compare.new
file = File.open('doc.xml')

File.foreach(file).with_index do |line, line_num|
  puts "#{line_num}: #{line}"
  line = line.chomp

  if compare.evaluate_line(line) == true
    compare.compare_same_tag(line)
    compare.validate_text_inside_tags(line)
  end

  compare.compare_first_line(line) if line_num.zero?

  if compare.evaluate_multilineal_tag(line) == 1 && !line_num.zero? && compare.evaluate_line(line) == false
    compare.get_multilineal_initial_tag(line)
  elsif compare.evaluate_multilineal_tag(line) == 2
    compare.get_multilineal_lasting_tag(line)
  end

  compare.evaluate_quote_values(line) if compare.evaluate_quote_in_line(line) == true
end

compare.compare_multilineal

file.close
