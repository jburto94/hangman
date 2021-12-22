class Hangman
  attr_accessor :remaining_attempts, :guess_letters, :current_progress
  attr_reader :word

  def random_word(dictionary)
    valid_words = dictionary.select { |word| (word.length).between?(5, 12) }
    valid_words.sample.chomp
  end

  def generate_word
    dictionary = []
    file = File.open('../5desk.txt').readlines.each do |word|
      dictionary << word
    end
    random_word(dictionary)
  end

  def initialize
    @remaining_attempts = 10
    @guess_letters = []
    @word = generate_word
    @current_progress = Array.new(@word.length, '_')
  end
end