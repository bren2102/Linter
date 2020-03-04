class Compare
  def evaluate_line(line)
    if line.count('<') == 2 && line.count("\/") == 1 && line.count('>') == 2
      true
    else
      false
    end
  end

  def get_tag_initial(line)
    if line.index(' ')
      if line.index(' ') < line.index('>')
        tag_initial = line[(line.index('<') + 1)...line.index(' ')]
      elsif line.index(' ') > line.index('>')
        tag_initial = line[(line.index('<') + 1)...line.index('>')]
      end
    elsif !line.index(' ')
      tag_initial = line[(line.index('<') + 1)...line.index('>')]
    end
    tag_initial
  end

  def get_tag_end(line)
    line[(line.index("\/") + 1)...line.rindex('>')]
  end

  def compare_same_tag(line)
    tag_initial = get_tag_initial(line)
    tag_end = get_tag_end(line)
    if tag_initial == tag_end
      puts 'Tags Match'
    else
      puts '[ERROR] Tags do not Match'
    end
  end

  def get_first_line(line)
    return line if line[2]=='x' && line[4]=='l'
  end

  def compare_first_line(line)
    first_line = get_first_line(line)
    if first_line
      puts 'First line exists'
    else
      puts '[WARNING]'
    end
  end
end
