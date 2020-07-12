# frozen_string_literal: true

# Helper for NumbersController
class NumbersHelper
  ZERO = 'zero'

  NUMERIC = {
    1_000_000 => 'million',
    1000 => 'thousand',
    100 => 'hundred',
    90 => 'ninety',
    80 => 'eighty',
    70 => 'seventy',
    60 => 'sixty',
    50 => 'fifty',
    40 => 'forty',
    30 => 'thirty',
    20 => 'twenty',
    19 => 'nineteen',
    18 => 'eighteen',
    17 => 'seventeen',
    16 => 'sixteen',
    15 => 'fifteen',
    14 => 'fourteen',
    13 => 'thirteen',
    12 => 'twelve',
    11 => 'eleven',
    10 => 'ten',
    9 => 'nine',
    8 => 'eight',
    7 => 'seven',
    6 => 'six',
    5 => 'five',
    4 => 'four',
    3 => 'three',
    2 => 'two',
    1 => 'one'
  }.freeze

  def self.to_words(value)
    value.zero? ? ZERO : to_words_util(value)
  end

  def self.to_words_util(value)
    in_words = ''

    NUMERIC.each do |num, name|
      if value.zero?
        return ''
      elsif value.to_s.length == 1 && (value / num).positive?
        return in_words + name.to_s
      elsif value < 100 && (value / num).positive?
        return in_words + name.to_s if (value % num).zero?

        return in_words + "#{name} " + to_words_util(value % num)
      elsif (value / num).positive?
        return in_words + to_words_util(value / num) + " #{name} " + to_words_util(value % num)
      end
    end
  end
end
