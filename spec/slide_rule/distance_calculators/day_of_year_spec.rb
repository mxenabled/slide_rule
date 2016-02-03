require 'spec_helper'

describe ::SlideRule::DistanceCalculators::DayOfYear do
  context 'when dates are an exact match' do
    it 'should return a 0 distance' do
      expect(described_class.new.calculate('2015-10-8', '2015-10-8')).to eq(0.0)
    end

    it 'should accept epoch date' do
      expect(described_class.new.calculate(1_444_262_400, 1_444_262_400)).to eq(0.0)
    end
  end

  context 'when dates are more than a year apart' do
    it 'should return a 1 distance' do
      expect(described_class.new.calculate('2015-10-8', '2016-10-8')).to eq(1)
    end
  end

  context 'when dates are in the same year but different' do
    it 'should return a calculated distance distance' do
      expect(described_class.new.calculate('2015-10-8', '2015-11-8')).to eq(0.08)
    end
  end

  context 'when there is a threshold' do
     it 'should return a 1 distance when there are too many days apart' do
      expect(described_class.new.calculate('2016-02-03', '2016-03-09', :threshold => 30)).to eq(1)
     end

     it 'should return a more sane number' do
      result_with_threshold = described_class.new.calculate('2016-02-03', '2016-02-10', :threshold => 30)
      result_without_threshold = described_class.new.calculate('2016-02-03', '2016-02-10')
      
      expect(result_with_threshold).to be > result_without_threshold
     end
  end
end
