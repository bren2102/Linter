class Compare

  def evaluate_line(line)
    if line.count('<') == 2 && line.count("\/") == 1 && line.count('>') == 2
      true
    else
      false
    end
  end

  def compare_same_tag(line)
    if line.index(' ')
      if line.index(' ') < line.index('>')
        tag_initial = line[(line.index('<')+1)...line.index(' ')]
      elsif line.index(' ') > line.index('>')
        tag_initial = line[(line.index('<')+1)...line.index('>')]
      end
    elsif !line.index(' ')
      tag_initial = line[(line.index('<')+1)...line.index('>')]
    end
    tag_end = line[(line.index("\/")+1)...line.rindex('>')]
    if (tag_initial == tag_end)
      puts 'Tags Match'
    else
      puts '[ERROR] Tags do not Match'
    end
  end
end

#compare = Compare.new
#puts compare.compare_same_tag('<Movies genre = “Science Fiction”>',0)