# frozen_string_literal: true

require_relative '../../app/helpers/numbers_helper'

RSpec.describe NumbersHelper do
  context 'to_words' do
    it 'should return zero' do
      result = described_class.to_words(0)
      expect(result).to eq('zero')
    end

    it 'should call to_words_utils' do
      allow(described_class).to receive(:to_words_util).and_return('stubbed one hundered twenty three')
      expect(described_class).to receive(:to_words_util)
      described_class.to_words(123)
    end
  end

  context 'to_words_utils' do
    it 'should return value in words' do
      expect(described_class.to_words_util(0)).to eq('')
      expect(described_class.to_words_util(1)).to eq('one')
      expect(described_class.to_words_util(11)).to eq('eleven')
      expect(described_class.to_words_util(20)).to eq('twenty')
      expect(described_class.to_words_util(21)).to eq('twenty one')
      expect(described_class.to_words_util(999)).to eq('nine hundred ninety nine')
    end
  end
end
