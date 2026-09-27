class WordGuesserGame
  attr_accessor :word, :guesses, :wrong_guesses

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

def guess(letter)
  unless letter.is_a?(String) && letter.match?(/\A[a-zA-Z]\z/)
    raise ArgumentError, 'Guess must be a single letter'
  end
  letter = letter.downcase
  return false if @guesses.include?(letter) || @wrong_guesses.include?(letter)
  if @word.include?(letter)
    @guesses << letter
  else
    @wrong_guesses << letter
  end
  true
end

def word_with_guesses
  @word.chars.map do |letter|
    @guesses.include?(letter) ? letter : '-'
  end.join
end

def check_win_or_lose
  return :lose if @wrong_guesses.length >= 7
  return :win if word_with_guesses == @word
  :play
end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('https://randomword.saasbook.info/RandomWord.txt')
    Net::HTTP.get(uri)
  end
end
