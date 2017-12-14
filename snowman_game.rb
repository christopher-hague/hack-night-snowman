AVAILABLE_LETTERS = ("a".."z").map { |letter| letter }

WORDS = ["apples", "dog", "hangman", "about", "greeting", "season", "winter", "uncommon", "Wednesday", "guessing"]

$incorrect_guesses = 0

def check_guess(word, char)
  if word.include?(char.downcase) && AVAILABLE_LETTERS.include?(char.downcase)
    AVAILABLE_LETTERS.delete(char)
  else
    AVAILABLE_LETTERS.delete(char)
    $incorrect_guesses += 1
  end
  puts display_word(word)
end

def has_won?(word)
  display_word(word).split(" ").join("").downcase == word
end

def has_lost?
  $incorrect_guesses >= 7
end

def display_word(word)
  word.split("").map do |char|
    if AVAILABLE_LETTERS.include?(char.downcase)
      " _ "
    else
      " " + char.downcase + " "
    end
  end
  .join("")
end

def display_snowman
  # try using .read method (it won't return the file object). If read doesn't do it, there is a method that will
  File.open("snowman_image.txt").each_with_index do |line, index|
    puts line unless index > 20 - ($incorrect_guesses * 3)
  end
  # returning nil prevents the <File> from being returned, which is what File.open will do by default
  return nil
end

def play_game
  word = ''
  puts "Welcome to Snowman!!!!"
  display_snowman

  puts "Would you like to play with a random word or with a word of your choosing? Input 'random' for a random word, or enter the word you would like to play with."
  user_word_choice = gets.chomp
  if user_word_choice.downcase == 'random'
    word = WORDS.sample
  else
    word = user_word_choice
  end

  puts "Here is your word. Save Frosty!!!"
  puts display_word(word)

  while !has_won?(word) && !has_lost?
    puts "*********************************************************************"
    puts display_snowman
    puts "The following letters have yet to be guessed:"
    puts AVAILABLE_LETTERS.join(" - ")
    puts display_word(word)
    puts "Guess a letter:"
    letter = gets.chomp
    check_guess(word, letter)
  end

  puts "***********************************************************************"

  if has_won?(word)
    puts "You saved Frosty! Happy Birthday!"
  else
    puts "You killed Frosty! WTF, dude?"
    puts "The word was '#{word}'."
  end
end

play_game
