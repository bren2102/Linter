require 'colorize'

class Compare
  def initialize()
    @multilineal_tag = []
  end

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
      puts 'Tags Match'.green
    else
      puts '[ERROR] Tags do not Match'.red
    end
  end

  def get_first_line(line)
    return line if line[2] == 'x' && line[4] == 'l'
  end

  def compare_first_line(line)
    first_line = get_first_line(line)
    if first_line
      puts 'First line exists'.green
    else
      puts '[WARNING]'.red
    end
  end

  def evaluate_multilineal_tag(line)
    if line.count('<') == 1 && line.count('>') == 1 && line.count("\/") == 0 && line.count('?') == 0
      return 1
    elsif line.count('<') == 1 && line.count('>') == 1 && line.count("\/") == 1
      return 2
    else
      return false
    end
  end

  def get_multilineal_initial_tag(line)
    @multilineal_tag.push(line[(line.index('<') + 1)...line.index(' ')]) 
  end

  def get_multilineal_lasting_tag(line)
    @multilineal_tag.delete(line[(line.index("\/") + 1)...line.index('>')]) 
  end

  def compare_multilineal
    if !@multilineal_tag.empty?
      puts "[ERROR] open tag on #{@multilineal_tag}".red
    else
      puts 'No open tag found'.green
    end
  end

  def evaluate_quote_in_line(line)
    if line.count('=') >= 1
      return true
    else
      return false
    end
  end

  def evaluate_quote_values(line)
    if /[A-Za-z]+\s*=\s*\"(.)+\"/ === line
      puts 'Exists quote'.green
    else
      puts 'Missing quote'.red
    end
  end
end
