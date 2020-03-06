require 'colorize'
# evalua si hay algo dentro de los tags
class Compare
  attr_reader :multilineal_tag

  def initialize()
    @multilineal_tag = []
  end

  private

  def get_q_atributes(line)
    line.count('=')
  end

  def get_q_quotes(line)
    line.count('"')
  end

  public

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
    return line[(line.index("\/") + 1)...line.rindex('>')] if line.index("\/")
    
    false
  end

  def get_first_line(line)
    return true if /xml/ === line
  end

  def both_question_mark?(line)
    true if line[1] == '?' && line[line.length - 2] == '?'
  end

  def initial_multiline?(line)
    return true if line.count('<') == 1 && line.count('>') == 1 && line.count('\/') == 0 #/^\s*<[^\/][^xml]+>\s*$/ === line

    false
  end

  def ending_multiline?(line)
    return true if line.count('<') == 1 && line.count('>') == 1 && line.count("\/") == 1

    false
  end

  def evaluate_line(line)
    if /^\s*<.+>\s*.\s*<\/.+>\s*$/ === line || /^\s*<.+>\s*.+\s*$/ === line #line.count('<') == 2 && line.count("\/") == 1 && line.count('>') == 2
      true
    else
      false
    end
  end

  def compare_same_tag(line)
    tag_initial = get_tag_initial(line)
    tag_end = get_tag_end(line)
    if tag_initial == tag_end
      puts '[OK] Tags Match'.green
      true
    elsif tag_initial && !tag_end
      puts '[ERROR] Missing tag end'.red
      false
    else
      puts '[ERROR] Tags do not Match'.red
      false
    end
  end

  def validate_text_inside_tags(line)
    if /<.+>\s*.+\s*<.+>/ === line
      puts '[OK] Has text inside'.green
      true
    elsif /<.+>\s*<.+>/ === line
      puts '[ERROR] Has no text inside'.red
      false
    end
  end

  def compare_first_line(line)
    first_line = get_first_line(line)
    if first_line
      if both_question_mark?(line)
        puts '[OK] XML prolog correct syntax'.green
        true
      else
        puts '[ERROR] XML prolog incorrect syntax'.red
        false
      end
    end
  end

  def evaluate_multilineal_tag(line)
    if initial_multiline?(line)
      1
    elsif ending_multiline?(line)
      2
    else
      false
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
      puts "[ERROR] Open tag multiline on #{@multilineal_tag}".red
      false
    else
      puts '[OK] No open tag multiline found'.green
      true
    end
  end

  def evaluate_quote_in_line(line)
    line.count('=') >= 1
  end

  def evaluate_quote_values(line)
    q_atributes = get_q_atributes(line)
    q_quotes = get_q_quotes(line)
    if 2 * q_atributes == q_quotes
      puts '[OK] No malformed atributes'.green
      true
    else
      puts '[ERROR] Malformed atributes. Missing quotes'.red
      false
    end
  end
end
