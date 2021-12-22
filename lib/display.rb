class Display
  def remaining_attempts(attempts)
    puts "You have #{attempts} attempts remaining"
  end

  def win
    puts "Congratulations! You saved them!"
  end

  def loss
    puts "Darn! It looks like the hangman is getting paid for that one."
  end

  def answer(word)
    puts "The word was: #{word}"
  end

  def progress(current)
    current.each { |spot| print "#{spot} " }
    puts
  end

  def previous_guesses(guesses)
    p guesses
  end

  def prompt_guess
    puts "Please enter a new number to solve the word."
    gets.chomp
  end
end