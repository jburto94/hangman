require_relative 'display'

class Hangman
  attr_accessor :attempts, :guess_letters, :current_progress
  attr_reader :word, :display

  def random_word(dictionary)
    valid_words = dictionary.select { |word| (word.length).between?(5, 12) }
    valid_words.sample.chomp.downcase
  end

  def generate_word
    dictionary = []
    file = File.open('5desk.txt').readlines.each do |word|
      dictionary << word
    end
    random_word(dictionary)
  end

  def initialize
    @attempts = 10
    @guess_letters = []
    @word = generate_word
    @current_progress = Array.new(@word.length, '_')
    @display = Display.new
  end

  def get_guess
    guess = display.prompt_guess
    valid_guess?(guess) ? guess.downcase : get_guess
  end

  def valid_guess?(char)
    return false if guess_letters.include?(char)
    ('a'..'z').to_a.include?(char) || ('A'..'Z').to_a.include?(char)
  end

  def play
    until won? || lost?
      display.remaining_attempts(attempts)
      display.previous_guesses(guess_letters)
      display.progress(current_progress)
      guess = get_guess
      correct_guess?(guess) ? place_guess(guess) : @attempts -= 1
      guess_letters << guess
    end

    won? ? display.win : display.loss
    display.answer(word)
  end

  def correct_guess?(guess)
    unless guess_letters.include?(guess)
      return word.include?(guess)
    end

    false
  end

  def place_guess(guess)
    indices = []
    word.each_char.with_index do |char, i|
      indices << i if char == guess
    end

    indices.each { |idx| current_progress[idx] = guess }
  end

  def won?
    current_progress.none?('_')
  end

  def lost?
    attempts <= 0
  end
end