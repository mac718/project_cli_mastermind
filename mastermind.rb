require 'pry'

class Board
  attr_accessor :guess_number
  def initialize
    @board = []
    @hints = []
    @guess_number = 0
  end

  def increment_guess_number
    @guess_number += 1
  end

  def display_board(hint)
    @board.each_with_index do |row, i| 
      print row
      print @hints[i]
      print "\n"
    end
  end

  def prompt_for_guess
    if @guess_number == 0
      puts "Enter your first guess. If it matches the code maker's code, 
            you win! Otherwise, the code maker will give you clues to help
            you along."
    else
      puts "Nope! Try again!"
    end
  end

  def add_guess(guess)
    @board << guess
  end

  def create_hint(guess, code)
    hint = []
    code.each_with_index do |peg, i|
      if peg == guess[i]
        hint << 'BL'
      elsif guess.include?(peg)
        hint << 'WH'
      end
    end
    @hints << hint
  end
end

class CodeMaker
  attr_reader :code 

  def initialize
    @pegs = %w(R G B Y O T)
    @code = []
    4.times { @code << @pegs.sample }
  end
end 

class CodeBreaker
  def make_guess
    @guess = gets.chomp.split('')
  end
end 

class Game 
  def initialize 
    @codemaker = CodeMaker.new
    @codebreaker = CodeBreaker.new
    @board = Board.new
  end

  def play
    while @guess != @codemaker.code
      p @code = @codemaker.code
      @board.prompt_for_guess
      @guess = @codebreaker.make_guess
      @board.add_guess(@guess)
      @board.increment_guess_number
      @hint = @board.create_hint(@guess, @code)
      @board.display_board(@hint)
    end
  end
end

game = Game.new
game.play