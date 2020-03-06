require './lib/compare.rb'

describe Compare do
  let(:logic) { Compare.new }

  describe '#validate_inline' do
    it 'validates if is an inline node' do
      expect(logic.evaluate_line('<Director>Christopher Nolan</Director>')).to eql(true)
    end
    it 'validates if is an inline node negative' do
      expect(logic.evaluate_line('<Movie name = "Interstellar">')).not_to eql(true)
    end
  end

  describe '#get_tag_initial' do
    it 'validates if tag initial exists and returns it' do
      expect(logic.get_tag_initial('<Director>Christopher Nolan</Director>')).to eql('Director')
    end
    it 'validates if tag initial exists and returns it' do
      expect(logic.get_tag_initial('<Year>2014</Year>')).to eql('Year')
    end
    it 'validates if tag initial exists and returns it negative' do
      expect(logic.get_tag_initial('<Movie name = "Interstellar">')).to eql('Movie')
    end
  end

  describe '#get_tag_end' do
    it 'validates if tag end exists and returns it' do
      expect(logic.get_tag_end('<Director>Christopher Nolan</Director>')).to eql('Director')
    end
    it 'validates if tag end exists and returns it' do
      expect(logic.get_tag_end('<Actor character = "Max">Tom Hardy</Actor>')).to eql('Actor')
    end
  end

  describe '#compare_same_tag' do
    it 'validates if tag initial is the same than tan tag end' do
      expect(logic.compare_same_tag('<Actor character = "Cooper">Mathew McConaughey</Actor>')).to eql(true)
    end
    it 'validates if tag initial is the same than tan tag end negative' do
      expect(logic.compare_same_tag('<actor character = "Cooper">Mathew McConaughey</Actor>')).not_to eql(true)
    end
  end

  describe '#validate_text_inside_tags' do
    it 'validates if there is text inside the tags' do
      expect(logic.validate_text_inside_tags('<Year>2014</Year>')).to eql(true)
    end
    it 'validate if there is text inside the tags negative' do
      expect(logic.validate_text_inside_tags('<Year></Year>')).not_to eql(true)
    end
  end

  describe '#get_first_line' do
    it 'validate if is the first line' do
      expect(logic.get_first_line('<?xml version="1.0" encoding="UTF-8"?>')).to eql(true)
    end
    it 'validate if is the first line negative' do
      expect(logic.get_first_line('<Movies genre = "Science Fiction">')).not_to eql(true)
    end
  end

  describe '#both_question_mark?' do
    it 'validate if the first line has question marks' do
      expect(logic.both_question_mark?('<?xml version="1.0" encoding="UTF-8"?>')).to eql(true)
    end
    it 'validate if the first line has question marks negative' do
      expect(logic.both_question_mark?('<xml version="1.0" encoding="UTF-8">')).not_to eql(true)
    end
  end

  describe '#compare_first_line' do
    it 'validate if the first line exists and the syntax is correct' do
      expect(logic.compare_first_line('<?xml version="1.0" encoding="UTF-8"?>')).to eql(true)
    end
    it 'validate if the first line exists and the syntax is correct negative' do
      expect(logic.compare_first_line('<?xml version="1.0" encoding="UTF-8">')).not_to eql(true)
    end
  end

  describe '#initial_multiline?' do
    it 'validate if is the inital of multiline' do
      expect(logic.initial_multiline?('<Movie name = "Interstellar">')).to eql(true)
    end
    it 'validate if is the inital of multiline negative' do
      expect(logic.initial_multiline?('<Director>Christopher Nolan</Director>')).not_to eql(true)
    end
  end

  describe '#ending_multiline?' do
    it 'validate if the first line has question marks' do
      expect(logic.ending_multiline?('</Movie>')).to eql(true)
    end
    it 'validate if the first line has question marks' do
      expect(logic.ending_multiline?('<Movie name = "Interstellar">')).not_to eql(true)
    end
    it 'validate if the first line has question marks negative' do
      expect(logic.ending_multiline?('<Director>Christopher Nolan</Director>')).not_to eql(true)
    end
  end

  describe '#evaluate_multilineal_tag' do
    it 'validate if has multilineal tags' do
      expect(logic.evaluate_multilineal_tag('<Movie name = "Interstellar">')).to eql(1)
    end
    it 'validate if has multilineal tags negative' do
      expect(logic.evaluate_multilineal_tag('</Movie>')).not_to eql(1)
    end
    it 'validate if has multilineal tags negative' do
      expect(logic.evaluate_multilineal_tag('<Actor character = "Dr Brand">Michael Caine</Actor>')).not_to eql(1)
    end
    it 'validate if has multilineal tags' do
      expect(logic.evaluate_multilineal_tag('</Movie>')).to eql(2)
    end
    it 'validate if has multilineal tags negative' do
      expect(logic.evaluate_multilineal_tag('<Movie name = "Interstellar">')).not_to eql(2)
    end
    it 'validate if has multilineal tags negative' do
      expect(logic.evaluate_multilineal_tag('<Actor character = "Dr Brand">Michael Caine</Actor>')).not_to eql(2)
    end
  end

  describe '#evaluate_quote_in_line' do
    it 'validate if there are quotes on the line' do
      expect(logic.evaluate_quote_in_line('<Movie name = "Interstellar">')).to eql(true)
    end
    it 'validate if there are quotes on the line negative' do
      expect(logic.evaluate_quote_in_line('<Year>2014</Year>')).not_to eql(true)
    end
    it 'validate if there are quotes on the line negative' do
      expect(logic.evaluate_quote_in_line('</Movies>')).not_to eql(true)
    end
  end

  describe 'evaluate_quote_values' do
    it 'validate if there are quotes on the line' do
      expect(logic.evaluate_quote_values('<Movie name = "Interstellar">')).to eql(true)
    end
    it 'validate if there are quotes on the line negative' do
      expect(logic.evaluate_quote_values('<?xml version="1.0" encoding="UTF-8?>')).not_to eql(true)
    end
    it 'validate if there are quotes on the line negative' do
      expect(logic.evaluate_quote_values('<Movie name = "Interstellar>')).not_to eql(true)
    end
  end
end
